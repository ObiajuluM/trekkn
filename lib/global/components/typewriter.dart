import 'dart:async';
import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration speed;
  final Duration cursorBlinkSpeed;

  /// Declare in the longer text block
  final VoidCallback? onComplete;

  const TypewriterText({
    super.key,
    required this.text,
    this.style = const TextStyle(fontSize: 24),
    // this.speed = const Duration(milliseconds: 0),
    this.speed = const Duration(milliseconds: 50),
    this.cursorBlinkSpeed = const Duration(milliseconds: 500),
    this.onComplete,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _visibleText = "";
  int _charIndex = 0;
  bool _showCursor = true;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _startTyping();
    _startCursorBlink();
  }

  void _startTyping() async {
    while (_charIndex < widget.text.length) {
      await Future.delayed(widget.speed);
      if (!mounted) return;
      setState(() {
        _charIndex++;
        _visibleText = widget.text.substring(0, _charIndex);
      });
    }
    if (widget.onComplete != null) {
      widget.onComplete!();
    }
  }

  void _startCursorBlink() {
    _cursorTimer = Timer.periodic(widget.cursorBlinkSpeed, (timer) {
      if (mounted) {
        setState(() => _showCursor = !_showCursor);
      }
    });
  }

  @override
  void dispose() {
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _visibleText + (_showCursor ? "|" : ""),
      style: widget.style,
    );
  }
}
