import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walkit/global/components/appsizing.dart';
import 'package:walkit/modules/formatter.dart';
import 'package:walkit/modules/model/providers.dart';
import 'package:walkit/pages/balance/balance.dart';
import 'package:walkit/pages/goal/goal.dart';
import 'package:walkit/pages/home/providers/methods.dart';
import 'package:walkit/pages/missions/missions.dart';
import 'package:walkit/pages/topboard/topboard.dart';
import 'package:walkit/themes/theme_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _shownZeroStepsPopup = false;

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open link')),
      );
    }
  }

  @override
  void initState() {
    // ref.read(stepCountProvider.notifier).setStep();
    super.initState();

    // Show popup if initial step count is zero (after first frame)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        final initialSteps = ref.read(stepCountProvider);
        if (mounted && !_shownZeroStepsPopup && initialSteps == 0) {
          _shownZeroStepsPopup = true;
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(
                'No steps yet!',
                style: TextStyle(
                  color: Colors.red.shade900,
                ),
              ),
              content: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    const TextSpan(
                      text:
                          "We haven't detected any steps today. If you haven't just taken any steps today ignore this popup.\n\n",
                    ),
                    TextSpan(
                        text:
                            'Otherwise, this could be caused by an issue - click me to see how to fix it.',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _openUrl("https://walkkn.com/faq/step-permission");
                          }),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      });
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    final stepCount = ref.watch(stepCountProvider);
    final user = ref.watch(trekknUserProvider);

    ///
    return Scaffold(
      ///
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ///
          Container(
            height: AppSizing.height(context) * 0.4,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              // color: Colors.white,
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),

            // padding: EdgeInsets.all(24),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: CircularProgressBar(
                        // divide steps by goal
                        // at 100_000 format to 100k
                        progress: stepCount / (user.goal ?? 1000),
                        goal: (user.goal ?? 1000).toDouble(),
                        progressColor:
                            Theme.of(context).colorScheme.onPrimaryFixedVariant,
                        backgroundColor: Colors.transparent,
                        markerColor: Colors.white,
                        markerSize: 24,
                      )),
                ),

                /// will show if user has a valid multiplier
                Visibility(
                  visible: false,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.outline,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                        ),
                      ),
                      height: 40,
                      width: 40,
                      child: const Text(
                        "x0.05", // 0.05 - 0.1
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          ///
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 3,
            children: [
              ///
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GoalPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.amber
                          : Colors.amber.withValues(alpha: 0.5),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // <a href="https://www.flaticon.com/free-icons/goal" title="goal icons">Goal icons created by Freepik - Flaticon</a>
                        Image.asset(
                          "assets/icons/goal.png",
                          height: 24,
                          width: 24,
                        ),
                        // Text(""),
                        const Text("goal"),
                      ],
                    ),
                  ),
                ),
              ),

              ///
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TopboardPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.indigo
                          : Colors.indigo.withValues(alpha: 0.5),
                      // borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // <a href="https://www.flaticon.com/free-icons/leaderboard" title="leaderboard icons">Leaderboard icons created by Yogi Aprelliyanto - Flaticon</a>
                        Image.asset(
                          "assets/icons/topboard.png",
                          height: 24,
                          width: 24,
                        ),
                        const Text("top board"),
                      ],
                    ),
                  ),
                ),
              ),

              ///
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BalancePage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.teal
                          : Colors.teal.withValues(alpha: 0.5),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      // border: BoxBorder.all(
                      //   color: Colors.teal,
                      // ),
                    ),
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //  <a href="https://www.flaticon.com/free-icons/accounting" title="accounting icons">Accounting icons created by KP Arts - Flaticon</a>
                        Image.asset(
                          "assets/icons/wallet.png",
                          height: 24,
                          width: 24,
                        ),

                        const Text("balance"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// container for missions
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: AppSizing.height(context) * 0.15,
            alignment: Alignment.center,
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: ListTile(
              onLongPress: () {
                ref.read(themeModeProvider.notifier).changeTheme();
              },
              onTap: () async {
                // await getUserMissions();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MissionsPage()));
              },
              title: const Text("Missions"),
              subtitle: const Text(
                  "Complete missions to earn rewards and receive badges"),
              trailing: Lottie.asset(
                "assets/lotties/walkingshoes.json",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A custom circular progress bar widget with animation, a center label, and a marker.
class CircularProgressBar extends StatefulWidget {
  final double progress; // value between 0 and 1
  final double goal;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;
  final Color markerColor;
  final double markerSize;

  const CircularProgressBar({
    super.key,
    required this.progress,
    required this.goal,
    this.progressColor = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.strokeWidth = 10.0,
    this.markerColor = Colors.blue,
    this.markerSize = 12.0,
  });

  @override
  State<CircularProgressBar> createState() => _CircularProgressBarState();
}

class _CircularProgressBarState extends State<CircularProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0.0, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() => setState(() {}));

    _currentProgress = widget.progress;
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant CircularProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress) {
      _animation =
          Tween<double>(begin: _currentProgress, end: widget.progress).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
      _controller.forward(from: 0.0);
      _currentProgress = widget.progress;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = min(constraints.maxWidth, constraints.maxHeight);

        return Stack(
          alignment: Alignment.center,
          children: [
            // Circular painter
            CustomPaint(
              size: Size(size, size),
              painter: _CircularProgressPainter(
                progress: _animation.value,
                progressColor: widget.progressColor,
                backgroundColor: widget.backgroundColor,
                strokeWidth: widget.strokeWidth,
                markerColor: widget.markerColor,
                markerSize: widget.markerSize,
              ),
            ),
            // Center content
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${(widget.progress * widget.goal).toInt() >= 1000000 ? compactCurrencyFormat.format((widget.progress * widget.goal).toInt()) : currencyFormat.format((widget.progress * widget.goal).toInt())} ",
                  style: TextStyle(
                    fontFamily: "EvilEmpire",
                    fontSize: size * 0.2,
                    color: widget.progressColor,
                    fontWeight: FontWeight.bold,
                  ),
                  // style: TextStyle(
                  //   fontSize: size * 0.2,
                  //   fontWeight: FontWeight.bold,
                  //   color: widget.progressColor,
                  // ),
                ),
                Text(
                  "steps",
                  style: TextStyle(
                    fontSize: size * 0.08,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// CustomPainter to draw the background, progress arcs, and marker.
class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;
  final Color markerColor;
  final double markerSize;

  _CircularProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
    required this.markerColor,
    required this.markerSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );

    // Draw marker at the end of the arc
    if (progress > 0) {
      final markerAngle = startAngle + sweepAngle;
      final markerOffset = Offset(
        center.dx + radius * cos(markerAngle),
        center.dy + radius * sin(markerAngle),
      );

      final markerPaint = Paint()..color = markerColor;
      canvas.drawCircle(markerOffset, markerSize / 2, markerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
