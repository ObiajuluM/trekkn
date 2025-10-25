import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:walkit/modules/formatter.dart';
import 'package:walkit/modules/launch_something.dart';
import 'package:walkit/modules/model/providers.dart';

import 'package:walkit/pages/ranking/ranking.dart';
import 'package:walkit/pages/settings/settings.dart';

import 'package:avatar_plus/avatar_plus.dart';

class MePage extends ConsumerStatefulWidget {
  const MePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MePageState();
}

class _MePageState extends ConsumerState<MePage> {
  //

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(trekknUserProvider);

    ///
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          /// profile picture
          CircleAvatar(
            radius: 50,
            child: AvatarPlus(
              "${user.username}",
              trBackground: true,
            ),
          ),

          ///
          Container(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              // onLongPress: () {
              //   print("Long press for theme change");
              //   ref.read(themeModeProvider.notifier).changeTheme();
              // },
              title: Text("${user.displayname}"),
              subtitle: Text(
                "${user.email}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              trailing: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(8),
                child: Image.asset(
                  "assets/logos/google_small.png",
                  height: 30,
                ),
              ),
            ),
          ),

          ///
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.25,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    // bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Image.asset(
                    //   "assets/icons/xp.png", // <a href="https://www.flaticon.com/free-icons/xp" title="xp icons">Xp icons created by Falcone - Flaticon</a>
                    //   height: 30,
                    // ),
                    Container(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.lightBlueAccent,
                        // color: Colors.blue.shade900,
                        // color: Colors.blueGrey,
                      ),
                      child: TweenAnimationBuilder<int>(
                          tween: IntTween(
                              begin: user.aura == null ? null : 0,
                              end: user.aura ?? 0), // animate from 0 → 4500
                          duration: const Duration(seconds: 1),
                          builder: (context, value, child) {
                            return Text(
                              value >= 1000000
                                  ? compactCurrencyFormat.format(value)
                                  : currencyFormat.format(value),
                              style: const TextStyle(
                                fontFamily: "EvilEmpire",
                                // color: Colors.lightBlueAccent,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                    ),
                    const Text(
                      "aura",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),

              /// opens to a global ranking page, by level
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GlobalRankingPage()));
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      // bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: Colors.orange,
                        ),
                        child: TweenAnimationBuilder<int>(
                            tween: IntTween(
                                begin: user.level == null ? null : 0,
                                end: user.level ?? 0), // animate from 0 → 4500
                            duration: const Duration(seconds: 1),
                            builder: (context, value, child) {
                              return Text(
                                value >= 1000000
                                    ? compactCurrencyFormat.format(value)
                                    : currencyFormat.format(
                                        value), // find way to arrange this maths, max out at 150
                                style: const TextStyle(
                                  fontFamily: "EvilEmpire",
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                      ),
                      const Text(
                        "level",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              ///
              GestureDetector(
                onTap: () async {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const FriendsPage()));
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: Colors.purple,
                        ),
                        child: TweenAnimationBuilder<int>(
                            key: ValueKey("friends"),
                            tween: IntTween(
                                begin: 0, end: 0), // animate from 0 → 4500
                            duration: const Duration(seconds: 0),
                            builder: (context, value, child) {
                              return Text(
                                value >= 1000000
                                    ? compactCurrencyFormat.format(value)
                                    : currencyFormat.format(
                                        value), // find way to arrange this maths, max out at 150
                                style: const TextStyle(
                                  fontFamily: "EvilEmpire",
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                      ),
                      const Text(
                        "friends",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              ///
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: ShapeDecoration(
                        shape: const CircleBorder(),
                        color: Colors.red.shade900,
                      ),
                      child: TweenAnimationBuilder<int>(
                          tween: IntTween(
                              begin: user.streak == null ? null : 0,
                              end: user.streak ?? 0), // animate from 0 → 4500
                          duration: const Duration(seconds: 5),
                          builder: (context, value, child) {
                            return Text(
                              value >= 1000000
                                  ? compactCurrencyFormat.format(value)
                                  : currencyFormat.format(value),
                              style: const TextStyle(
                                fontFamily: "EvilEmpire",
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                    ),
                    const Text(
                      "streak",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ],
          ),

          ///
          Card(
            margin: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              onTap: () async {
                await SharePlus.instance.share(ShareParams(
                  title: "Tell someone about Walk It",
                  text:
                      'Get Paid to Walk when you walk with Walk It.\nYou get rewarded when you sign up with this link: ${user.inviteUrl}',
                ));
              },
              title: const Text(
                "Invite a friend to Walk It",
                style: TextStyle(
                    // color: Theme.of(context).colorScheme.secondaryFixedDim,
                    ),
              ),
              trailing: Image.asset(
                "assets/icons/invite.png",
                height: 30,
              ),
              tileColor: Theme.of(context)
                  .colorScheme
                  .inversePrimary, // <a href="https://www.flaticon.com/free-icons/group" title="group icons">Group icons created by Freepik - Flaticon</a>
              // tileColor: Theme.of(context)
              //     .colorScheme
              //     .onSecondaryFixedVariant, // <a href="https://www.flaticon.com/free-icons/group" title="group icons">Group icons created by Freepik - Flaticon</a>
            ),
          ),

          ///
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  openUrl("https://walkitapp.com");
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                child: Icon(
                  Icons.public_sharp,
                  color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                ),
              ),

              ///
              ElevatedButton(
                onPressed: () {
                  openUrl("https://x.com/walkitapp");
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                child: Text(
                  String.fromCharCodes([0xD835, 0xDD4F]),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color:
                        Theme.of(context).colorScheme.onSecondaryFixedVariant,
                    // fontSize: 24,
                    // color: Colors.grey,
                  ),
                ),
              ),

              ///
              ElevatedButton(
                onPressed: () {
                  openUrl("https://discord.gg/8at5m9Bx");
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                child: Icon(
                  Icons.discord,
                  color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                child: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
