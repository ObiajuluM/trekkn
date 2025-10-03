import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/modules/formatter.dart';
import 'package:walkit/modules/model/providers.dart';
import 'package:walkit/pages/balance/balance.dart';
import 'package:walkit/pages/explore/explore.dart';
import 'package:walkit/pages/home/home.dart';
import 'package:walkit/pages/home/providers/methods.dart';
import 'package:walkit/pages/me/me.dart';
import 'package:walkit/pages/primary/providers/provider.dart';

class PrimaryPage extends ConsumerStatefulWidget {
  const PrimaryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PrimaryPageState();
}

class _PrimaryPageState extends ConsumerState<PrimaryPage> {
  late PageController pageController = PageController(
    initialPage: 1,
  );

  @override
  void initState() {
    indexLookUP(1);
    super.initState();
  }

  indexLookUP(int index) async {
    if (index == 1) {
      ref.read(stepCountProvider.notifier).setStep();
      ref.read(trekknUserProvider.notifier).setUser();
    } else if (index == 2) {
      // ref.read(trekknUserProvider.notifier).setUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(primaryPageIndexProvider);

    final user = ref.watch(trekknUserProvider);
    final balance = user.balance ?? 0;

    return Scaffold(
      // change appbar title based on current page
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: currentPage == 0
            ? Text(
                "Explore",
              )
            : currentPage == 1
                ? Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hi ',
                          style: TextStyle(),
                        ),
                        TextSpan(
                          text: "${user.displayname}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text("Me"),

        ///
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BalancePage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/wallet.png",
                    height: 24,
                    width: 24,
                  ),
                  Text(
                    balance >= 1000000
                        ? compactCurrencyFormat.format(balance)
                        : currencyFormat.format(balance),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///
          // IconButton(
          //   onPressed: () async {
          //     // await getUser();
          //   },
          //   icon: Icon(Icons.notifications_none_rounded),
          // ),
        ],
      ),

      ///
      body: PageView.builder(
        controller: pageController,
        itemCount: 3,
        onPageChanged: (value) async {
          ref.read(primaryPageIndexProvider.notifier).setIndex(value);
          indexLookUP(value);
        },
        itemBuilder: ((context, index) => const [
              ExplorePage(),
              HomePage(),
              MePage(),
            ].elementAt(index)),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          // jump to page
          ref.read(primaryPageIndexProvider.notifier).setIndex(index);

          ///
          pageController.jumpToPage(index);

          indexLookUP(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_people_outlined),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}
