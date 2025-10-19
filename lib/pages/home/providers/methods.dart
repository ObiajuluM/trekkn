import 'package:riverpod/riverpod.dart';
import 'package:health/health.dart';

Future<int> getAndroidStepCount() async {
  try {
    // health instance
    final health = Health();

    // config health instance
    await health.configure();

    // data types to work with
    List<HealthDataType> dataTypes = [HealthDataType.STEPS];

    // get steps for today (i.e., since midnight)
    // today
    final now = DateTime.now();
    // midnight
    final midnight = DateTime(now.year, now.month, now.day);

    // return list of step count
    List<HealthDataPoint> healthSteps = await health.getHealthDataFromTypes(
      startTime: midnight,
      endTime: now,
      types: dataTypes,
      recordingMethodsToFilter: [
        RecordingMethod.manual,
      ],
    );

    // loop through data points, sort by platform: HealthPlatformType. and sourceName
    final stepCount = healthSteps.where((point) {
      return point.sourceName == "com.google.android.apps.fitness" &&
          point.sourcePlatform == HealthPlatformType.googleHealthConnect;
    }).fold<int>(0, (sum, point) {
      // Ensure value is an int (steps are numeric but sometimes double)
      final value = point.value.toJson()["numericValue"] as int;
      return sum + value;
    });
    return stepCount;
  } catch (e) {
    return 0;
  }
}

class StepCountProvider extends StateNotifier<int> {
  StepCountProvider() : super(0) {
    setStep();
  }

  setStep() async {
    state = await getAndroidStepCount();
  }
}

final stepCountProvider = StateNotifierProvider<StepCountProvider, int>((ref) {
  return StepCountProvider();
});
