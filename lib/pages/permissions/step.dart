import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:walkit/global/components/typewriter.dart';
import 'package:walkit/global/components/appsizing.dart';
import 'package:walkit/modules/api/backend.dart';
import 'package:walkit/modules/background/background_step_process.dart';
import 'package:walkit/modules/launch_something.dart';

import 'package:walkit/pages/home/providers/methods.dart';
import 'package:walkit/pages/primary/primary.dart';

class StepPermissionPage extends ConsumerStatefulWidget {
  final Response? response;
  const StepPermissionPage(this.response, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StepPermissionPageState();
}

class _StepPermissionPageState extends ConsumerState<StepPermissionPage> {
  late final StreamSubscription<String?> _tokenSub;

  bool doneCapping = false;
  bool googleFitAvailable = false;
  bool healthConnectAvailable = false;
  bool visible = false;
  // Global Health instance

  Future<bool> getHealthConnectState() async {
    final health = Health();
    // configure the health plugin before use.
    await health.configure();
    final avail = await health.isHealthConnectAvailable();
    healthConnectAvailable = avail;

    return avail;
  }

  @override
  void initState() {
    getHealthConnectState();
    _tokenSub = ApiClient().accessTokenStream.listen((token) {
      if (token != null && mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => PrimaryPage()),
          (route) => false,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tokenSub.cancel();
    super.dispose();
  }

  // request step permission
  Future<bool> requestStepPermission() async {
    bool hasPermission = false;

    try {
      // Global Health instance
      final health = Health();
      // configure the health plugin before use.
      await health.configure();

      const List<HealthDataType> kdataTypes = [HealthDataType.STEPS];

      hasPermission = await health.hasPermissions(kdataTypes) ?? false;

      if (hasPermission) {
        // set the step
        ref.read(stepCountProvider.notifier).setStep();
      } else {
        hasPermission =
            await health.requestAuthorization(kdataTypes).then((value) async {
          await requestStepPermission();
          return true;
        });
      }
    } catch (e) {
      log(e.toString());
    }

    return hasPermission;
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      ///
      appBar: AppBar(
        actionsPadding: const EdgeInsets.all(8),
        title: const Text(
          "Step Data",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Image.asset(
            "assets/icons/step.png", // <a href="https://www.flaticon.com/free-icons/steps" title="steps icons">Steps icons created by Freepik - Flaticon</a>
            height: 24,
            width: 24,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // Text(
          //   "Finally...",
          //   style: TextStyle(
          //     fontSize: 24,
          //     color: Colors.green,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),

          TypewriterText(
            text:
                "I'd like access to your step data from your health provider for tracking activity & rewards.",
            style: const TextStyle(fontSize: 24),
            onComplete: () {
              setState(() {
                doneCapping = true;
                visible = true;
              });
            },
          ),

          TypewriterText(
            text: "\nYou can manage access anytime in settings.",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
                fontSize: 24),
            onComplete: () {},
          ),

          ///
          SizedBox(height: AppSizing.height(context) * 0.05),

          ///
          Visibility(
            visible: visible,
            child: Column(children: [
              const Text(
                "Please ensure you have the following apps installed and setup",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),

              /// health connect
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image.asset(
                  "assets/logos/google_health_connect.png",
                  height: 32,
                  width: 32,
                ),
                title: const Text(
                  "Health Connect",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text("Google's health data platform"),
                // if hralth connect is avialibel tick good else icon
                onTap: () async {
                  await openUrl(
                      "https://play.google.com/store/apps/details?id=com.google.android.apps.healthdata");
                },
                trailing: Checkbox(
                    value: healthConnectAvailable, onChanged: (value) {}),
              ),

              /// Google Fit
              ListTile(
                onTap: () async {
                  await openUrl(
                      "https://play.google.com/store/apps/details?id=com.google.android.apps.fitness");
                  setState(() {
                    googleFitAvailable = true;
                  });
                },
                contentPadding: EdgeInsets.zero,
                leading: Image.asset(
                  "assets/logos/google_fit.png", // <a href="https://www.flaticon.com/free-icons/fit" title="fit icons">Fit icons created by Tinti Nodarse - Flaticon</a>
                  height: 32,
                  width: 32,
                ),
                title: const Text(
                  "Google Fit",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:
                    const Text("Health-tracking platform developed by Google"),
                trailing: Checkbox(
                    value: googleFitAvailable,
                    onChanged: (value) async {
                      setState(() {
                        googleFitAvailable = value!;
                      });
                    }),
              ),

              ///
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red.shade900,
                ),
                onPressed: () {},
                label: const Text("How to?"),
                icon: const Icon(
                  Icons.play_circle_outline_rounded,
                ),
              )
            ]),
          )
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
        //  if health connnect and google fit are availiable and steps permission granted
        onPressed: doneCapping == true &&
                healthConnectAvailable == true &&
                googleFitAvailable == true
            ? () {
                try {
                  Permission.activityRecognition.request().then((value) {
                    // validate if permission has been granted before pushing screen
                    if (value.isGranted && context.mounted) {
                      requestStepPermission().then((value) async {
                        if (value) {
                          // conditional start foreground task service to show steps notification
                          FlutterForegroundTask.isRunningService.then((value) {
                            if (value == false) {
                              ForegroundTaskService.init();
                              //
                              startService();
                            }
                          });

                          //
                          // save tokens to activate stream
                          if (!context.mounted) return;
                          await ApiClient().saveTokens(
                            widget.response!.data["access"],
                            widget.response!.data["refresh"],
                          );
                        }
                      });
                    }
                  });
                } catch (e) {
                  log(e.toString());
                }
              }
            : null,
        child: const Text(
          "Sure, why not",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
