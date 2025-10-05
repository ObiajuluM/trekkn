import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/modules/formatter.dart';
import 'package:walkit/modules/model/providers.dart';

class TopboardPage extends ConsumerStatefulWidget {
  const TopboardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopboardPageState();
}

class _TopboardPageState extends ConsumerState<TopboardPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Top Board"),

          ///
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            tabs: [
              // TODO too lazy to fix the timezone stuff, issue wiith inconsistent date
              Tab(child: Text("Recent")),
              Tab(child: Text("Week")),
              Tab(child: Text("Month")),
            ],
          ),
        ),

        ///
        body: TabBarView(
          children: [
            /// yesterday
            FutureBuilder(
                future: getStepLeaderboard(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final stepList = snapshot.data!;

                    return ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: stepList.length,
                        separatorBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                                vertical: 1, horizontal: 0),
                          );
                        },
                        itemBuilder: (context, index) {
                          final ranker = stepList[index];

                          return Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(index == 0 ? 12 : 0),
                                topRight: Radius.circular(index == 0 ? 12 : 0),
                                bottomLeft: Radius.circular(
                                    index == stepList.length - 1 ? 12 : 0),
                                bottomRight: Radius.circular(
                                    index == stepList.length - 1 ? 12 : 0),
                              ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                // radius: 50,
                                child: AvatarPlus(
                                  "${ranker.username}",
                                  trBackground: true,
                                ),
                              ),
                              title: Text("${ranker.displayname}"),
                              subtitle: Text(
                                  "${ranker.totalSteps! >= 1000000 ? compactCurrencyFormat.format(ranker.totalSteps) : currencyFormat.format(ranker.totalSteps)} steps"),
                              trailing: index == 0
                                  ? const Icon(
                                      Icons.star_rounded,
                                      color: Colors.yellow,
                                    )
                                  : index == 1
                                      ? const Icon(
                                          Icons.star_rounded,
                                          color: Colors.white,
                                        )
                                      : index == 2
                                          ? const Icon(
                                              Icons.star_rounded,
                                              color: Colors.brown,
                                            )
                                          : const SizedBox.shrink(),
                            ),
                          );
                        });
                  } else {
                    return Container();
                  }
                }),

            /// past week
            FutureBuilder(
                future: getStepLeaderboard("week"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final stepList = snapshot.data!;

                    return ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: stepList.length,
                        separatorBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                                vertical: 1, horizontal: 0),
                          );
                        },
                        itemBuilder: (context, index) {
                          final ranker = stepList[index];

                          return Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(index == 0 ? 12 : 0),
                                topRight: Radius.circular(index == 0 ? 12 : 0),
                                bottomLeft: Radius.circular(
                                    index == stepList.length - 1 ? 12 : 0),
                                bottomRight: Radius.circular(
                                    index == stepList.length - 1 ? 12 : 0),
                              ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                // radius: 50,
                                child: AvatarPlus(
                                  "${ranker.username}",
                                  trBackground: true,
                                ),
                              ),
                              title: Text("${ranker.displayname}"),
                              subtitle: Text(
                                  "${ranker.totalSteps! >= 1000000 ? compactCurrencyFormat.format(ranker.totalSteps) : currencyFormat.format(ranker.totalSteps)} steps"),
                              trailing: index == 0
                                  ? const Icon(
                                      Icons.star_rounded,
                                      color: Colors.yellow,
                                    )
                                  : index == 1
                                      ? const Icon(
                                          Icons.star_rounded,
                                          color: Colors.white,
                                        )
                                      : index == 2
                                          ? const Icon(
                                              Icons.star_rounded,
                                              color: Colors.brown,
                                            )
                                          : const SizedBox.shrink(),
                            ),
                          );
                        });
                  } else {
                    return Container();
                  }
                }),

            /// past month
            FutureBuilder(
                future: getStepLeaderboard("month"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final stepList = snapshot.data!;

                    return ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: stepList.length,
                        separatorBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                                vertical: 1, horizontal: 0),
                          );
                        },
                        itemBuilder: (context, index) {
                          final ranker = stepList[index];

                          return Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(index == 0 ? 12 : 0),
                                topRight: Radius.circular(index == 0 ? 12 : 0),
                                bottomLeft: Radius.circular(
                                    index == stepList.length - 1 ? 12 : 0),
                                bottomRight: Radius.circular(
                                    index == stepList.length - 1 ? 12 : 0),
                              ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                // radius: 50,
                                child: AvatarPlus(
                                  "${ranker.username}",
                                  trBackground: true,
                                ),
                              ),
                              title: Text("${ranker.displayname}"),
                              subtitle: Text(
                                  "${ranker.totalSteps! >= 1000000 ? compactCurrencyFormat.format(ranker.totalSteps) : currencyFormat.format(ranker.totalSteps)} steps"),
                              trailing: index == 0
                                  ? const Icon(
                                      Icons.star_rounded,
                                      color: Colors.yellow,
                                    )
                                  : index == 1
                                      ? const Icon(
                                          Icons.star_rounded,
                                          color: Colors.white,
                                        )
                                      : index == 2
                                          ? const Icon(
                                              Icons.star_rounded,
                                              color: Colors.brown,
                                            )
                                          : const SizedBox.shrink(),
                            ),
                          );
                        });
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
