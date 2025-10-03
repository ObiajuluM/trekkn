import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/modules/formatter.dart';
import 'package:walkit/modules/model/providers.dart';

class BalancePage extends ConsumerStatefulWidget {
  const BalancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BalancePageState();
}

class _BalancePageState extends ConsumerState<BalancePage> {
  final PageController pageController = PageController(viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(trekknUserProvider);
    final balance = user.balance ?? 0;

    ///
    return Scaffold(
      appBar: AppBar(
        title: const Text("Balance"),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.qr_code),
          // )
        ],
      ),

      ///
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 9, // this is to accomadate the design on this page
          vertical: 12,
        ),
        children: [
          SizedBox(
            height: 200, // fixed height for the PageView
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Walk Points",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Image.asset(
                          "assets/logos/walkit.png",
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    balance >= 1000000
                        ? compactCurrencyFormat.format(balance)
                        : currencyFormat.format(balance),
                    style: const TextStyle(
                      fontFamily: "EvilEmpire",
                      fontSize: 54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "\$WKP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///
          Container(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              // color: Colors.white,
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: FutureBuilder(
                future: getUserActivities(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final events = snapshot.data!;
                    return ListView.builder(
                      itemCount: events.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          tilePadding: const EdgeInsets.all(0),
                          shape: const Border(),
                          title: Text(
                            "${events[index].source.toUpperCase()} ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "Amount Rewarded: ${events[index].amountRewarded >= 1000000 ? compactCurrencyFormat.format(events[index].amountRewarded) : currencyFormat.format(events[index].amountRewarded)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: events[index].source == "steps"
                              ? const Icon(Icons.directions_walk)
                              : events[index].source == "referral"
                                  ? const Icon(Icons.group)
                                  : const Icon(Icons.ac_unit),
                          children: [
                            Text(
                                "Reward for ${events[index].source} on ${formatDate(events[index].timestamp.toLocal())} \$WKP"),
                          ],
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
