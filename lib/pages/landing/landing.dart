import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:walkit/global/components/appsizing.dart';
import 'package:walkit/modules/api/backend.dart';
import 'package:walkit/modules/auth/google_auth.dart';
import 'package:walkit/modules/device_id.dart';

import 'package:walkit/pages/permissions/notification.dart';
import 'package:walkit/themes/theme_provider.dart';

class LandingPage extends ConsumerStatefulWidget {
  final String? inviteCode;
  LandingPage({super.key, this.inviteCode});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      ///
      body: ListView(
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ///
          Container(
            height: AppSizing.height(context) * 0.6,
            margin: const EdgeInsets.only(
              bottom: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Theme.of(context).colorScheme.onPrimaryFixed,
            ),

            ///
            child: Lottie.asset('assets/lotties/walkingshoes.json'),
          ),

          ///
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Get rewarded for every step you take...",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                wordSpacing: 5,
              ),
            ),
          ),

          ///
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              "Turn your daily movement into tangible rewards. Walk, explore, and earn!",
              style: TextStyle(
                wordSpacing: 2,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),

      ///

      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          // backgroundColor: Colors.amber,
          // foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(
            horizontal: 70,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        onPressed: () async {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => const NotificationPermissionPage()));
          try {
            final (idToken, userId) = await signInWithGoogle();

            if (idToken != null) {
              // get device id hash
              final deviceId = await getDeviceId(userId!);

              final response = await backendLogin(
                idToken,
                deviceId,
                widget.inviteCode,
              );

              if (response.statusCode == 200 && context.mounted) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NotificationPermissionPage(response)));
              } else {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Login failed with status: ${response.statusCode}'),
                  ),
                );
              }
            }
          } catch (e) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login failed with status: $e'),
                duration: Duration(seconds: 5),
                action: SnackBarAction(
                    label: "send",
                    onPressed: () async {
                      await SharePlus.instance.share(ShareParams(
                        title: "Error Report",
                        text: 'Error when attempting to sign in $e',
                      ));
                    }),
              ),
            );

            //   if (response.statusCode == 200 && context.mounted) {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) =>
            //                 NotificationPermissionPage(response)));
            //   } else {
            //     if (!context.mounted) return;
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(
            //         content:
            //             Text('Login failed with status: ${response.statusCode}'),
            //       ),
            //     );
            //   }
            // }
          }
        },
        onLongPress: () async {
          log("Long press for theme change initaites logout");
          ref.read(themeModeProvider.notifier).changeTheme();
          await signOutFromGoogle();
        },
        icon: Image.asset(
          "assets/logos/google_small.png",
          height: 20,
          fit: BoxFit.cover,
        ),
        label: const Text(
          'Continue',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
