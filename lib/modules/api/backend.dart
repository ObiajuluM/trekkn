import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Singleton class for API integration
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late Dio dio;
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  // Stream to notify when access token changes
  final StreamController<String?> _accessTokenController =
      StreamController<String?>.broadcast();
  Stream<String?> get accessTokenStream => _accessTokenController.stream;

  // .asBroadcastStream(
  //   onListen: (subscription) async {
  //     await streamAccessToken();
  //   },
  // );

  static const String baseUrl = "http://192.168.1.61:8000/"; // your Django API
  static const String accessTokenKey = "access_token";
  static const String refreshTokenKey = "refresh_token";

  ApiClient._internal() {
    ///
    streamAccessToken();

    ///
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    // Attach interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Attach access token to every request
        String? token = await _storage.read(key: accessTokenKey);
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        // If 401, try refreshing the token
        if (e.response?.statusCode == 401) {
          final refreshed = await _refreshToken();
          if (refreshed) {
            // retry original request with new token
            final retryRequest = await _retryRequest(e.requestOptions);
            return handler.resolve(retryRequest);
          }
        }
        return handler.next(e);
      },
    ));
  }

  /// Retry failed request after refresh
  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final token = await _storage.read(key: accessTokenKey);
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        "Authorization": "Bearer $token",
      },
    );

    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  /// Refresh JWT token
  Future<bool> _refreshToken() async {
    final refresh = await _storage.read(key: refreshTokenKey);
    if (refresh == null) return false;

    try {
      final response = await dio.post(
        "auth/token/refresh/", // Django SimpleJWT refresh endpoint
        data: {"refresh": refresh},
        options: Options(headers: {"Authorization": null}), // no auth needed
      );

      if (response.statusCode == 200) {
        final newAccess = response.data["access"];
        await _storage.write(key: accessTokenKey, value: newAccess);
        _accessTokenController.add(newAccess);
        return true;
      }
    } catch (e) {
      await signOutFromServer();
      return false;
    }
    return false;
  }

  /// Save tokens after login
  Future<void> saveTokens(String access, String refresh) async {
    await _storage.write(key: accessTokenKey, value: access);
    await _storage.write(key: refreshTokenKey, value: refresh);
    _accessTokenController.add(access);
  }

  Future<void> streamAccessToken() async {
    final access = await _storage.read(key: accessTokenKey);
    _accessTokenController.add(access);
  }
}

/// Logout user → clear tokens TODO: also call signOut from Google
Future<bool?> signOutFromServer() async {
  // final access = await _storage.read(key: accessTokenKey);

  try {
    final refresh = await ApiClient()._storage.read(key: "refresh_token");
    final response = await ApiClient().dio.post("auth/sign-out/", data: {
      "refresh": refresh,
    });
    // if (response.statusCode == 205) {
    await ApiClient()._storage.delete(key: "refresh_token");

    ///
    await ApiClient()._storage.delete(key: "access_token");
    ApiClient()._accessTokenController.add(null);
    // ApiClient()._accessTokenController.close();

    return true;
    // }
  } catch (e, stacktrace) {
    log("server sign out failed: $e", stackTrace: stacktrace, error: e);
    return null;
  }
  // return null;
}

// Example: Login
Future<Response> backendLogin(String? idToken, String? deviceId) async {
  final response = await ApiClient().dio.post("auth/sign-in/", data: {
    "id_token": idToken,
    "device_id": deviceId,
  });

  //  await ApiClient().saveTokens(
  //   response.data["access"],
  //   response.data["refresh"],
  // );
  return response;
}


// // Example: Logout
// Future<void> signOut() async {
//   await api.logout();
// }

//  check if the server is live
// Create the custom instance
final connection = InternetConnection.createInstance(
  customConnectivityCheck: (option) async {
    try {
      final response = await ApiClient().dio.head(
            "health/",

            // options: Options(
            // headers: option.headers,
            // receiveTimeout: option.timeout,
            // validateStatus: (_) => true,
            // ),
          );
      return InternetCheckResult(
        option: option,
        isSuccess: response.statusCode == 200,
      );
    } catch (_) {
      return InternetCheckResult(option: option, isSuccess: false);
    }
  },
);
