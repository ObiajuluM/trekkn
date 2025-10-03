import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectWalletPage extends ConsumerStatefulWidget {
  const ConnectWalletPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConnectWalletPageState();
}

class _ConnectWalletPageState extends ConsumerState<ConnectWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(8),
        title: Text(
          "Connect Wallet",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Image.asset(
            "assets/icons/key.png", //<a href="https://www.flaticon.com/free-icons/key" title="key icons">Key icons created by Freepik - Flaticon</a>
            height: 24,
            width: 24,
          ),
        ],
      ),

      ///
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(238, 102, 44, 1),
                  // color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                  ),
                ),
                child: InkResponse(
                  splashColor: Color.fromRGBO(238, 102, 44, 1),
                  onTap: () {},
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ///
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/logos/metamask.png",
                            height: 48,
                            width: 48,
                          ),
                          Text(
                            "Continue with Metamask",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),

                      ///
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: Image.asset(
                          "assets/logos/somnia.png",
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ///
              Container(
                margin: EdgeInsets.only(top: 12, left: 0, right: 12, bottom: 0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                  ),
                ),
              ),

              ///
              Container(
                margin: EdgeInsets.only(top: 0, left: 12, right: 0, bottom: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),

              ///
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(147, 140, 59, 1),
                  // rgb(147, 140, 59)
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: InkResponse(
                  splashColor: const Color.fromRGBO(147, 140, 59, 1),
                  onTap: () {},
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/logos/solflare.png",
                            height: 48,
                            width: 48,
                          ),
                          Text(
                            "Continue with Solflare",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),

                      ///
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: Image.asset(
                          "assets/logos/solana.png",
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          ///
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 24,
                fontFamily: "NataSans",
                wordSpacing: 4,
              ),
              children: [
                ///
                TextSpan(
                  text: "Trekkn supports\n",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                ///
                TextSpan(
                  text: "Somnia",
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.purpleAccent,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () async {},
                ),

                ///
                TextSpan(
                  text: " & ",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                ///
                TextSpan(
                  text: "Solana",
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.green,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      // final Uri uri = Uri.parse("https://x.com/ferrousapp");
                      // if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                      //   throw Exception("Could not launch Twitter");
                      // }
                    },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
