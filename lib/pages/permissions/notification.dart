import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:walkit/global/components/typewriter.dart';
import 'package:walkit/pages/permissions/background.dart';
import 'package:walkit/pages/THE%20FOLDERS%20HERE%20SHOULD%20BE%20IN%20PAGES/connectwallet/connectwallet.dart';

class NotificationPermissionPage extends ConsumerStatefulWidget {
  final Response? response;
  const NotificationPermissionPage(this.response, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationPermissionPageState();
}

class _NotificationPermissionPageState
    extends ConsumerState<NotificationPermissionPage> {
  bool doneCapping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      ///
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(8),
        title: Text(
          "Send Notifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Image.asset(
            "assets/icons/bell.png", // <a href="https://www.flaticon.com/free-icons/notification" title="notification icons">Notification icons created by Pixel perfect - Flaticon</a>
            height: 24,
            width: 24,
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          TypewriterText(
            text:
                "I'd like to keep you updated! remind you about your progress & rewards.",
            style: TextStyle(fontSize: 24),
            onComplete: () {
              setState(() {
                doneCapping = true;
              });
            },
          ),

          ///
          TypewriterText(
            text:
                '\nYou can change your preferences anytime in your device settings.',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
                fontSize: 24),
          ),
        ],
      ),

      ///
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: doneCapping == true
              ? null
              : Theme.of(context).colorScheme.inverseSurface,
          padding: const EdgeInsets.symmetric(
            horizontal: 70,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        onPressed: doneCapping == true
            ? () async {
                Permission.notification.request().then((value) {
                  if (value.isGranted && context.mounted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BackgroundPermissionPage(widget.response)));
                  }
                });
              }
            : null,
        onLongPress: true == true
            ? () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConnectWalletPage()));
              }
            : null,
        child: const Text(
          "I'm ok with that",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
