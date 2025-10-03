import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BalancePage extends ConsumerStatefulWidget {
  const BalancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BalancePageState();
}

class _BalancePageState extends ConsumerState<BalancePage> {
  final PageController pageController = PageController(
    viewportFraction: 1,
  );
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Balance"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.qr_code),
          )
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
            child: PageView.builder(
              controller: pageController,
              itemCount: 2,
              onPageChanged: (value) {
                print(value);
                setState(() {
                  currentPage = value;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Somnia",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Image.asset(
                              "assets/logos/somnia.png",
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        (1000 * (index + 1)).toStringAsFixed(2),
                        style: TextStyle(
                          fontFamily: "EvilEmpire",
                          fontSize: 54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "OMI",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          ///
          Container(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              // color: Colors.white,
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            padding: EdgeInsets.all(12),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ExpansionTile(
                  tilePadding: EdgeInsets.all(0),
                  shape: Border(),
                  title: Text(
                    "20,000,000",
                  ),
                  subtitle: Text("20,000,000"),
                  trailing: Icon(Icons.star),
                  children: [
                    Text(DateTime.now().toString()),
                  ],
                ),

                ExpansionTile(
                  tilePadding: EdgeInsets.all(0),
                  shape: Border(),
                  title: Text("20,000,000"),
                  subtitle: Text("20,000,000"),
                  trailing: Icon(Icons.sunny),
                  children: [
                    Text(DateTime.now().toString()),
                  ],
                ),

                ExpansionTile(
                  tilePadding: EdgeInsets.all(0),
                  shape: Border(),
                  title: Text("20,000,000"),
                  subtitle: Text("20,000,000"),
                  trailing: Icon(Icons.window),
                  children: [
                    Text(DateTime.now().toString()),
                  ],
                ),

                ///
              ],
            ),
          ),
        ],
      ),
    );
  }
}
