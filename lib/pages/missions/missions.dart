import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/modules/formatter.dart';
import 'package:walkit/modules/model/providers.dart';

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
                        ? colorFromName(missions[index].mission.name)
                        : Colors.grey.shade200.withValues(alpha: 0.5),
                    elevation: missions[index].isCompleted == true ? null : 0,
                    clipBehavior: Clip.antiAlias,
                    child: GestureDetector(
                      // splashColor: Color.fromRGBO(44, 238, 57, 1),
                      onTap: () {},
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
                              style: const TextStyle(
                                color: Colors.grey,
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
