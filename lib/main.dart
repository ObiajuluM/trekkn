import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walkit/firebase_options.dart';
import 'package:walkit/global/flavor/config.dart';
import 'package:walkit/licenses.dart';
import 'package:walkit/modules/api/backend.dart';
import 'package:walkit/modules/background/schedule_notiifications.dart';
import 'package:walkit/modules/formatter.dart';
import 'package:walkit/pages/game/game.dart';
import 'package:walkit/pages/landing/landing.dart';
import 'package:walkit/pages/primary/primary.dart';
import 'package:walkit/themes/dark.dart';
import 'package:walkit/themes/light.dart';
import 'package:walkit/themes/theme_provider.dart';

// : Starting FGS with type health callerApp=ProcessRecord{a4fb993 18284:com.walkitapp.walkit/u0a914} targetSDK=35 requires permissions: all of the permissions allOf=true [android.permission.FOREGROUND_SERVICE_HEALTH] any of the permissions allOf=false [android.permission.ACTIVITY_RECOGNITION, android.permission.BODY_SENSORS, android.permission.HIGH_SAMPLING_RATE_SENSORS]

Future<void> main() async {
  // flutter binding stuff
  WidgetsFlutterBinding.ensureInitialized();

  //  do flavors for developement
  FlavorConfig(
    flavor: Flavor.prod,
    googleClientId:
        "871288827965-aeiu4daeqfl7r45k4tke5q3s21ovrbcb.apps.googleusercontent.com",
    baseUrl: "https://api.walkitapp.com/",
  );

  // load asset licenses
  licenses;

  // init notifications plugin
  await initNotifications();

  // schedule the walk reminder once
  await scheduleDailyWalkReminderOnce();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // awaiting seems safe
  await ApiClient().streamAccessToken();

  // DO FOR AUTHENTICATION VIA DEEP LINKS
  // final appLinks = AppLinks(); // AppLinks is singleton

  // // Subscribe to all events (initial link and further)
  // final sub = appLinks.uriLinkStream.listen((uri) {
  //   log("object $uri");
  // });

  // background stuff
  // if (await FlutterForegroundTask.isRunningService == false) {
  //   ForegroundTaskService.init();
  //   //
  //   startService();
  // }

  // force portrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // for apps over android 15
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  String? _latestUri;

  @override
  void initState() {
    super.initState();
    final appLinks = AppLinks();
    appLinks.uriLinkStream.listen((uri) {
      setState(() {
        _latestUri = extractInviteCode(uri);
      });
      log("object $uri");
    });
  }

  // load the preferred theme on startup
  loadPreferredThemeOnStartup() {
    SharedPreferences.getInstance().then((prefs) {
      bool? isNight = prefs.getBool('night');

      if (isNight == null) {
        ref.watch(themeModeProvider.notifier).setTheme(ThemeMode.system);
      }

      if (isNight == true) {
        ref.watch(themeModeProvider.notifier).toDark();
      }

      if (isNight == false) {
        ref.watch(themeModeProvider.notifier).toLight();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final tokenStream = ApiClient().accessTokenStream;
    // var isThereInternet = connection.onStatusChange;

    loadPreferredThemeOnStartup();

    ///
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.light,
      themeMode: ref.watch(themeModeProvider),

      builder: (context, child) {
        // Listen to the access token stream globally
        return StreamBuilder<InternetStatus>(
          stream: connection.onStatusChange,
          builder: (context, snapshot) {
            final isConnected = snapshot.data == InternetStatus.connected;
            if (!isConnected) {
              return GamePage(
                inviteCode: _latestUri,
              );
              // return const Scaffold(
              //   body: Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.wifi_off, size: 64, color: Colors.red),
              //         SizedBox(height: 16),
              //         Text(
              //           'No Connection To Server',
              //           style: TextStyle(fontSize: 20, color: Colors.red),
              //         ),
              //       ],
              //     ),
              //   ),
              // );
            }
            return child!;
          },
        );
      },

      home: StreamBuilder(
        // stream: tokenStream,
        initialData: null,
        stream: ApiClient().accessTokenStream.asBroadcastStream(
          onListen: (subscription) async {
            await ApiClient().streamAccessToken();
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PrimaryPage();
          }
          return LandingPage(
            inviteCode: _latestUri,
          );
        },
      ),
    );
  }
}
