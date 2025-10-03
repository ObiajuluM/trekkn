import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/modules/formatter.dart';
import 'package:walkit/modules/model/providers.dart';
import 'dart:developer';

import 'package:walkit/pages/missions/components/anime.dart';

class MissionsPage extends ConsumerStatefulWidget {
  const MissionsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MissionsPageState();
}

class _MissionsPageState extends ConsumerState<MissionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.all(8),
        title: const Text(
          "Missions",
        ),
      ),

      ///
      body: FutureBuilder(
          future: getUserMissions(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final missions = snapshot.data!;

              return GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: missions.length,
                shrinkWrap: true,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),

                ///
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(2),
                    color: missions[index].isCompleted == true
                        ? colorFromName(
                            missions[index].mission.id,
                            Theme.of(context).brightness,
                          )
                        : Colors.grey.shade200.withValues(alpha: 0.5),
                    elevation: missions[index].isCompleted == true ? null : 0,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      // splashColor: Color.fromRGBO(44, 238, 57, 1),
                      onTap: () {
                        log("message");
                        showMissionDialog(
                          context,
                          name: missions[index].mission.name,
                          description: missions[index].mission.description,
                          requirementSteps:
                              missions[index].mission.requirementSteps,
                          isCompleted: missions[index].isCompleted,
                          auraReward: missions[index].mission.auraReward,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/star.png", // <a href="https://www.flaticon.com/free-icons/rating" title="rating icons">Rating icons created by O.moonstd - Flaticon</a>
                              height: 48,
                              color: missions[index].isCompleted
                                  ? null
                                  // ? colorFromName(missions[index].mission.name)
                                  : Colors.grey,
                              // width: 24,
                            ),

                            ///
                            Text(
                              missions[index].mission.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: missions[index].isCompleted == true
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          }),
    );
  }
}

void showMissionDialog(
  BuildContext context, {
  required String name,
  required String description,
  required int requirementSteps,
  required bool isCompleted,
  required int auraReward,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 12),
            Text("Steps Required: $requirementSteps"),
            Text("Aura Reward: $auraReward"),
          ],
        ),
        actions: [
          ///
          if (isCompleted) DrawnCheck(),

          ///
          // IconButton(
          //   onPressed: () => Navigator.of(context).pop(),
          //   icon: Icon(
          //     Icons.close,
          //     color: Colors.red.shade900,
          //   ),
          // ),
        ],
      );
    },
  );
}
