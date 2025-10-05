import 'dart:async';
import 'dart:developer';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:walkit/modules/api/backend.dart';
import 'package:walkit/modules/formatter.dart';
import 'package:walkit/modules/model/models.dart';
import 'package:walkit/modules/model/providers.dart';
import 'package:walkit/pages/home/providers/methods.dart';

Future<void> rewardAndLogSteps(int steps) async {
  if (DateTime.now().hour == 23
      //  &&
      // steps >= 100
      ) {
    log("enter 1");

    try {
      final response = await ApiClient().dio.get("/activities/");
      final List<dynamic> data = response.data;

      // Convert to model
      final activities =
          data.map((json) => DailyActivity.fromJson(json)).toList();

      // Filter only those with source "steps"
      final stepActivities = activities
          .where((activity) => activity.source.toLowerCase() == "steps")
          .toList();

      if (stepActivities.isEmpty) {
        // show love here too
        log("No step-based activities found, will have to show love");
        final showLove = await setDailySteps(steps);
        log(showLove.toString());
        // return null;
      }
      // Sort by timestamp (latest first)
      stepActivities.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      final lastStepActivity = stepActivities.first;

      // Compare dates (ignoring time)
      final now = DateTime.now();
      final isSameDay = lastStepActivity.timestamp.year == now.year &&
          lastStepActivity.timestamp.month == now.month &&
          lastStepActivity.timestamp.day == now.day;

      if (!isSameDay) {
        log("showing love");
        final showLove = await setDailySteps(steps);
        log(showLove.toString());
        // show love
      }

      return null;
    } catch (e) {
      log("Error trying to show love: $e");
      return null;
    }
  }
  return null;
}

const channelId = "Walk It Channel Id";
const channelName = "Walk It Service Notification";
const channelDescription =
    "This notification appears when the walk it service is running.";

///
class ForegroundTaskService {
  static init() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: channelId,
        channelName: channelName,
        channelDescription: channelDescription,
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(
          Duration(
            minutes: 15,
          ).inMilliseconds,
        ),
        // eventAction: ForegroundTaskEventAction.nothing(),
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWakeLock: true,
        // allowWifiLock: true,
      ),
    );
  }
}

// This decorator means that this function calls native code
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

void startService() async {
  try {
    // final healthSteps = await getBackgroundStepCount();
    final healthSteps = await getAndroidStepCount();

    if (await FlutterForegroundTask.isRunningService) {
      FlutterForegroundTask.restartService();
    } else {
      // show step notification
      FlutterForegroundTask.startService(
        notificationTitle:
            "${healthSteps >= 1000000 ? compactCurrencyFormat.format(healthSteps) : currencyFormat.format(healthSteps)} steps today",
        notificationText: "",
        callback:
            startCallback, // Function imported from ForegroundService.dart
      );
    }
  } catch (e) {
    log("error during start service $e");
  }
}

void stopService() async {
  bool isRunning = await FlutterForegroundTask.isRunningService;
  if (isRunning) {
    await FlutterForegroundTask.stopService();
    print("Foreground task stopped.");
  } else {
    print("No foreground task running.");
  }
}

class MyTaskHandler extends TaskHandler {
  // Called when the task is started.
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    ///
    print('onStart(starter: ${starter.name})');

    // get steps
    final healthSteps = await getAndroidStepCount();

    // set initial step notification
    FlutterForegroundTask.startService(
      notificationTitle:
          "${healthSteps >= 1000000 ? compactCurrencyFormat.format(healthSteps) : currencyFormat.format(healthSteps)} steps today",
      serviceTypes: [
        // ForegroundServiceTypes.health,
        // ForegroundServiceTypes.dataSync,
      ],
      notificationText: "",
      callback: startCallback, // Function imported from ForegroundService.dart
    );
    // show love
    await rewardAndLogSteps(healthSteps);
  }

  // Called based on the eventAction set in ForegroundTaskOptions.
  @override
  void onRepeatEvent(DateTime timestamp) async {
    log("object  repeated ${timestamp}");
    final healthSteps = await getAndroidStepCount();

    // update step notification
    FlutterForegroundTask.updateService(
      // notificationTitle: "${await getBackgroundStepCount()} steps today",
      notificationTitle:
          "${healthSteps >= 1000000 ? compactCurrencyFormat.format(healthSteps) : currencyFormat.format(healthSteps)} steps today",
      notificationText: "",
    );
    // show love
    await rewardAndLogSteps(healthSteps);
  }

  // Called when the task is destroyed.
  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    print('onDestroy');
  }

  // Called when data is sent using `FlutterForegroundTask.sendDataToTask`.
  @override
  void onReceiveData(Object data) {
    print('onReceiveData: $data');
  }

  // Called when the notification button is pressed.
  @override
  void onNotificationButtonPressed(String id) {
    print('onNotificationButtonPressed: $id');
  }

  // Called when the notification itself is pressed.
  @override
  void onNotificationPressed() {
    print('onNotificationPressed');
  }

  // Called when the notification itself is dismissed.
  @override
  void onNotificationDismissed() {
    print('onNotificationDismissed');
  }
}
