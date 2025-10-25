import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:walkit/modules/background/background_step_process.dart';

Future<void> scheduleDailyWalkReminderOnce() async {
  final prefs = await SharedPreferences.getInstance();
  final hasScheduled = prefs.getBool('walk_reminder_scheduled') ?? false;

  if (!hasScheduled) {
    await scheduleDailyWalkReminder(); // the function from before
    await prefs.setBool('walk_reminder_scheduled', true);
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> scheduleDailyWalkReminder() async {
  // Initialize timezone (required)
  tz.initializeTimeZones();

  final now = tz.TZDateTime.now(tz.local);

  // Pick a random hour between 10 and -
  final random = Random();
  int randomHour = 10 + random.nextInt(8); // 10,11,12,13,14
  var scheduledTime = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    randomHour,
    0,
  );

  // If the time already passed today, schedule for tomorrow
  // final nextTime = scheduledTime.isBefore(now)
  //     ? scheduledTime.add(const Duration(days: 1))
  //     : scheduledTime;

  var nextTime = scheduledTime;

  NotificationDetails platformDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      // importance: Importance.defaultImportance ,
      // priority: Priority.defaultPriority ,
    ),
  );

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0, // notification ID
    'Time to Walk 🚶‍♂️',
    'Take a few steps and earn with Walk It!',
    nextTime,
    platformDetails,
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time, // repeat daily
  );

  ///
  ///
  ///
  /// reminder for good night
  ///
  ///
  ///

  randomHour = 20 + random.nextInt(4);
  scheduledTime = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    randomHour,
    0,
  );

  nextTime = scheduledTime;

  await flutterLocalNotificationsPlugin.zonedSchedule(
    1, // notification ID
    'Goodnight Walker 🌛',
    'Rest well, you deserve it!',
    nextTime,
    platformDetails,
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time, // repeat daily
  );

  ///
  ///
  ///
  ///
  ///
  /// reminder to open app by 11 PM
  final openAppHour = 23; // 11 PM local time
  final openAppTime = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    openAppHour,
    0,
  );

  final nextOpenAppTime = openAppTime;

  await flutterLocalNotificationsPlugin.zonedSchedule(
    2, // notification ID
    '🔥It\'s time to sync your steps and keep rewards flowing.',
    'Open Walk It or make sure it is running in the background!',
    nextOpenAppTime,
    platformDetails,
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time, // repeat daily
  );
}
