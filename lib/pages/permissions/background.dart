// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:walkit/global/components/typewriter.dart';
import 'package:walkit/modules/background/background_step_process.dart';
import 'package:walkit/pages/permissions/location.dart';
import 'package:walkit/pages/permissions/step.dart';

class BackgroundPermissionPage extends ConsumerStatefulWidget {
  final Response? response;
  const BackgroundPermissionPage(this.response, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BackgroundPermissionPageState();
}

// <a href="https://www.flaticon.com/free-icons/music-and-multimedia" title="music and multimedia icons">Music and multimedia icons created by Vektorify - Flaticon</a>

class _BackgroundPermissionPageState
    extends ConsumerState<BackgroundPermissionPage> {
  bool doneCapping = false;
  bool alarmAndBackground = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      ///
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(8),
        title: Text(
          "Background Access",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Image.asset(
            "assets/icons/background.png", // <a href="https://www.flaticon.com/free-icons/music-and-multimedia" title="music and multimedia icons">Music and multimedia icons created by Vektorify - Flaticon</a>
            height: 24,
            width: 24,
            color: Colors.blueAccent,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          ///
          TypewriterText(
            text:
                "Permit me to track your steps in the background, even if the app is closed.",
            style: TextStyle(fontSize: 24),
            onComplete: () {
              setState(() {
                doneCapping = true;
              });
            },
          ),

          ///
          TypewriterText(
            text: '\nYou can disable this anytime in your settings.',
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
                Permission.ignoreBatteryOptimizations.request().then((value) {
                  if (value.isGranted && context.mounted) {
                    Permission.scheduleExactAlarm.request().then((value) {
                      if (value.isGranted && context.mounted) {
                        // conditional start foreground task stuff
                        // FlutterForegroundTask.isRunningService.then((value) {
                        //   if (value == false) {
                        //     ForegroundTaskService.init();
                        //     //
                        //     startService();
                        //   }
                        // });

                        ///
                        // if (!context.mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    StepPermissionPage(widget.response)));
                      }
                    });
                  }
                });
              }
            : null,
        child: const Text(
          "Yes, please",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
