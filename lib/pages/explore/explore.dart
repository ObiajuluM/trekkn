import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/misc/appsizing.dart';
import 'package:walkit/pages/THE%20FOLDERS%20HERE%20SHOULD%20BE%20IN%20PAGES/booststep/booststep.dart';
import 'package:walkit/pages/THE%20FOLDERS%20HERE%20SHOULD%20BE%20IN%20PAGES/challenge/challenge.dart';
import 'package:walkit/pages/THE%20FOLDERS%20HERE%20SHOULD%20BE%20IN%20PAGES/multiplier/multiplier.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      body: true == true
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.build, size: 64, color: Colors.blueGrey),
                  SizedBox(height: 16),
                  Text(
                    'Under Construction, Check Later!',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                /// ad box for partners
                Container(
                  height: AppSizing.height(context) * 0.3,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("execute ad action");
                        },
                        child: Center(
                            child: Image.asset(
                          "assets/icons/sam.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                            // child: Text("ad box - ever updating field of ads"),
                            ),
                      ),

                      /// ad icon,  on click gives you info and tells you to contact us for your own
                      Positioned(
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red.shade900,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            height: 40,
                            width: 40,
                            child: const Text(
                              "AD",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 4,
                    right: 4,
                    bottom: 4,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MultiplierPage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                          ),
                        ),
                        child: const Text("multiplier"),
                      ),
                    ),

                    ///
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChallengesPage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: const Text("challenges"),
                      ),
                    ),
                  ],
                ),

                ///
                Container(
                  height: AppSizing.height(context) * 0.2,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: const Text("Events"),
                ),

                ///
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  padding: const EdgeInsets.only(
                    top: 4,
                    left: 4,
                    right: 4,
                    bottom: 12,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ///
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: const Text("Earn More(watch ads)"),
                    ),

                    ///
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BoostStepPage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: const Text("Boost Step"),
                      ),
                    ),
                  ],
                ),

                ///
                Container(
                  height: AppSizing.height(context) * 0.2,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text("stay updated!"),
                ),
              ],
            ),
    );
  }
}
