import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

// class AvoidBlocksGame extends StatelessWidget {
//   const AvoidBlocksGame({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: GamePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class GamePage extends StatefulWidget {
  final String? inviteCode;
  const GamePage({super.key, this.inviteCode});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double playerX = 0.5;
  double blockX = 0.5;
  double blockY = 0.0;
  int score = 0;
  bool isPlaying = false;
  Timer? timer;
  final random = Random();
  double blockSpeed = 0.02;

  void startGame() {
    setState(() {
      isPlaying = true;
      score = 0;
      playerX = 0.5;
      blockX = random.nextDouble();
      blockY = 0;
      blockSpeed = 0.02;
    });

    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 30), (t) {
      setState(() {
        blockY += blockSpeed;

        if (blockY > 1.0) {
          blockY = 0;
          blockX = random.nextDouble();
          score++;
          blockSpeed += 0.002; // gets faster each point
        }

        // collision detection
        if ((blockX - playerX).abs() < 0.1 && blockY > 0.85) {
          // Game over
          isPlaying = false;
          t.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void movePlayer(DragUpdateDetails details, Size size) {
    setState(() {
      playerX += details.delta.dx / size.width;
      playerX = playerX.clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onHorizontalDragUpdate: (details) => movePlayer(details, size),
      onTap: () {
        //
        if (!isPlaying) startGame();
      },
      child: Scaffold(
        //
        body: Stack(
          children: [
            // Score
            Positioned(
              top: 50,
              left: 20,
              child: Text(
                "Score: $score",
                // "Score: $score ${widget.inviteCode}",
                style: const TextStyle(
                  // color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ///
            Center(
              child: Center(
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

            // Falling Block
            Positioned(
              left: blockX * size.width,
              top: blockY * size.height,
              child: const Block(),
            ),

            // Player
            Positioned(
              bottom: 50,
              left: playerX * size.width,
              child: const Player(),
            ),

            // Start / Game Over text
            if (!isPlaying)
              Center(
                child: Text(
                  score == 0
                      ? "Tap to Start"
                      : "Game Over\nScore: $score\nTap to Retry",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class Block extends StatelessWidget {
  const Block({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
