import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/modules/model/providers.dart';

class GlobalRankingPage extends ConsumerStatefulWidget {
  const GlobalRankingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GlobalRankingPageState();
}

class _GlobalRankingPageState extends ConsumerState<GlobalRankingPage>
    with TickerProviderStateMixin {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Global Ranking"),
      ),
      body: FutureBuilder(
          future: getLevelLeaderboard(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final globalList = snapshot.data!;
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: globalList.length,
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                        vertical: 1, horizontal: 0),
                  );
                },
                itemBuilder: (context, index) {
                  final ranker = globalList[index];

                  return Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(index == 0 ? 12 : 0),
                        topRight: Radius.circular(index == 0 ? 12 : 0),
                        bottomLeft: Radius.circular(
                            index == globalList.length - 1 ? 12 : 0),
                        bottomRight: Radius.circular(
                            index == globalList.length - 1 ? 12 : 0),
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
                      subtitle: Text("Level ${ranker.level}"),
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
                },
              );
            } else {
              return Center(
                child: Text("No Data"),
              );
            }
          }),
    );
  }
}
