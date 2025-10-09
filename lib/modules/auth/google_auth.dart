import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';

import 'package:walkit/global/flavor/config.dart';

Future<(String?, String?)> signInWithGoogle() async {
  try {
    // create instance
    final googleSignIn = GoogleSignIn.instance;

    // Initialize GoogleSignIn with required scopes
    await googleSignIn.initialize(
        clientId: FlavorConfig.instance.googleClientId,
        serverClientId:
            "871288827965-fu5qvubuipdrm9kdatq203t450n2s18m.apps.googleusercontent.com");

    // Start the sign-in process
    final googleUser = await googleSignIn.authenticate();

    // Obtain auth details
    final idToken = googleUser.authentication.idToken;
    final userId = googleUser.id;
    return (idToken, userId);
  } catch (e, stackTrace) {
    log('Google Sign-In failed: $e', stackTrace: stackTrace);
    return (null, null);
  }
}

Future<void> signOutFromGoogle() async {
  try {
    final googleSignIn = GoogleSignIn.instance;

    await googleSignIn.signOut();
    // log('User signed out from Google');
  } catch (e, stackTrace) {
    log('Google Sign-Out failed: $e', stackTrace: stackTrace);
  }
}
