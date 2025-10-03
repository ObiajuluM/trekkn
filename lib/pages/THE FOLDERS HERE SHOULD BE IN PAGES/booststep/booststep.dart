import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoostStepPage extends ConsumerStatefulWidget {
  const BoostStepPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BoostStepPageState();
}

class _BoostStepPageState extends ConsumerState<BoostStepPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Boost Step"),
      ),

      ///
      body: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(12),
          children: [
            Text(
                "one time purchase of nfts to boost your rewardable step count"),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: [
                Card(),
                Card(),
                Card(),
                Card(),
                Card(),
                Card(),
                Card(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
