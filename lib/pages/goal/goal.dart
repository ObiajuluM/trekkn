import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:walkit/misc/appsizing.dart';

import 'package:walkit/modules/model/providers.dart';

class GoalPage extends ConsumerStatefulWidget {
  const GoalPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GoalPageState();
}

class _GoalPageState extends ConsumerState<GoalPage> {
  double _goal = 1000; // default goal
  bool doneCapping = false;
  bool isUsingUserGoal = true;

  final List<int> _quickGoals = [1000, 3000, 5000, 8000, 10000, 15000];

  @override
  Widget build(BuildContext context) {
    var userGoal = ref.watch(trekknUserProvider).goal ?? 1000;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      ///
      appBar: AppBar(
        title: const Text("Set Your Goals"),
      ),

      ///
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          /// Current goal display
          Container(
            height: AppSizing.height(context) * 0.15,
            alignment: Alignment.center,
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: ListTile(
              ///
              leading: Lottie.asset(
                "assets/lotties/walkingshoes.json",
              ),

              ///
              title: Text(
                "${isUsingUserGoal == true ? userGoal : _goal.toInt()} steps",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// Quick pick chips
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: _quickGoals.map((value) {
              final isSelected = isUsingUserGoal == true
                  ? (userGoal.toInt() == value)
                  : (_goal.toInt() == value);
              return ChoiceChip(
                label: Text("$value"),
                selected: isSelected,
                onSelected: (_) {
                  _goal = value.toDouble();
                  isUsingUserGoal = false;
                  setState(() {});
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 30),

          /// Slider
          Slider(
            value: isUsingUserGoal == true
                ? userGoal.toDouble()
                : _goal.toDouble(),
            min: 1000,
            max: 20000,
            divisions: 19,
            label: "${isUsingUserGoal == true ? userGoal : _goal.toInt()}",
            onChanged: (value) {
              _goal = value.toDouble();
              isUsingUserGoal = false;
              setState(() {});
            },
          ),
        ],
      ),

      /// Save button
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // backgroundColor: Theme.of(context).colorScheme.inverseSurface,
          padding: const EdgeInsets.symmetric(
            horizontal: 70,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        onPressed: () async {
          // unendable loading circle
          showDialog(
            context: context,
            barrierDismissible: false, // can't dismiss by tapping outside
            builder: (BuildContext context) {
              return const PopScope(
                canPop: false, // ❌ block back button / swipe
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );

          ref
              .read(trekknUserProvider.notifier)
              .updateUser({"goal": _goal}).then((value) {
            if (!context.mounted) return;
            // pop loading wheel
            Navigator.pop(context);
            // show dialog
            showDialog(
                context: context,
                builder: (builder) {
                  return AlertDialog(
                      title: const Text("Goal set successfully!"));
                });
          });
        },
        child: const Text(
          "Set Goal!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
