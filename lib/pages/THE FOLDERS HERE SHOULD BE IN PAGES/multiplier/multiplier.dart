import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultiplierPage extends ConsumerStatefulWidget {
  const MultiplierPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BoostStepPageState();
}

class _BoostStepPageState extends ConsumerState<MultiplierPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiplier"),
      ),

      ///
      body: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(12),
          children: [
            Text("Purchase multiplier to boost your rewards, valid for 24 hrs"),
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
