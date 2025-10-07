import 'package:flutter/material.dart';
import 'package:walkit/main_dev.dart';
import 'package:walkit/pages/game/game.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (innerContext) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 64, color: Colors.orange),
              const SizedBox(height: 16),
              const Text(
                'No Connection To Server',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
