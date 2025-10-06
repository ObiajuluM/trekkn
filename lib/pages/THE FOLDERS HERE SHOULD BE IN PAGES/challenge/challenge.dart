import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkit/global/components/appsizing.dart';

class ChallengesPage extends ConsumerStatefulWidget {
  const ChallengesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends ConsumerState<ChallengesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Challenges"),
        actions: [
          // on pressed navigate to friend page to challenge
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.directions_boat_filled_outlined))
        ],
      ),

      ///
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // daily check in
          GridView.count(
            // padding: EdgeInsets.all(),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            childAspectRatio: 1,
            children: [
              Card(),
              Card(),
              Card(),
              Card(),
              Card(),
              Card(),
              Card(),
            ],
          ),

          /// ads
          Container(
            height: AppSizing.height(context) * 0.15,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(12)),
          ),

          /// title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Active Challenges",
              ),

              /// on pressed, open page of past challenges
              IconButton(onPressed: () {}, icon: Icon(Icons.history))
            ],
          ),

          /// List of active challenges
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(12)),
            child: Text("List of active challenges"),
          ),
        ],
      ),
    );
  }
}
