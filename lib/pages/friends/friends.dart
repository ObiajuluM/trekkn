import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendsPage extends ConsumerStatefulWidget {
  const FriendsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriendsPageState();
}

class _FriendsPageState extends ConsumerState<FriendsPage>
    with TickerProviderStateMixin {
  int? expandedIndex;

  final friends = [
    {"name": "obi", "level": 100, "aura": 10000000},
    {"name": "kene", "level": 100, "aura": 1000},
    {"name": "ada", "level": 100, "aura": 1000},
    {"name": "ph", "level": 100, "aura": 1000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Friends")),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: friends.length,
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 1, horizontal: 0),
          );
        },
        itemBuilder: (context, index) {
          final friend = friends[index];
          final isExpanded = expandedIndex == index;

          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(index == 0 ? 12 : 0),
                topRight: Radius.circular(index == 0 ? 12 : 0),
                bottomLeft:
                    Radius.circular(index == friends.length - 1 ? 12 : 0),
                bottomRight:
                    Radius.circular(index == friends.length - 1 ? 12 : 0),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  expandedIndex = isExpanded ? null : index;
                });
              },
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(),
                    title: Text(friend["name"] as String),
                    subtitle: Text("${friend['aura']} aura"),
                    trailing: IconButton(
                      icon: const Icon(Icons.abc), // challenge button
                      onPressed: () {
                        debugPrint("Challenge ${friend["name"]}");
                      },
                    ),
                  ),

                  /// expanding section with animation
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    alignment: Alignment.topCenter,
                    child: isExpanded
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Level: ${friend['level']}"),
                                TextButton.icon(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red.shade900,
                                  ),
                                  icon: const Icon(Icons.delete_forever),
                                  label: const Text("Unfriend"),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
