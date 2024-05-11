import 'package:flutter/material.dart';

class AnimatedTextWriter extends StatefulWidget {
  final String text;
  final Duration duration;
  final ValueChanged<bool> onTextWritingDone;
  final Color color;
  final double size;

  const AnimatedTextWriter(
      {super.key,
      required this.text,
      this.duration = const Duration(seconds: 2),
      required this.onTextWritingDone,
      this.color = Colors.grey,
      this.size = 20.0});

  @override
  State<AnimatedTextWriter> createState() => _AnimatedTextWriterState();
}

class _AnimatedTextWriterState extends State<AnimatedTextWriter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _charCountAnimation;
  late String displayedText;
  bool textWritten = false; // Track internal flag
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _charCountAnimation =
        IntTween(begin: 0, end: widget.text.length).animate(_controller);
    displayedText = '';
    _controller.addListener(() {
      if (_controller.isCompleted && !textWritten) {
        textWritten = true; // Update internal flag
        widget.onTextWritingDone(textWritten); // Call the callback
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        displayedText = widget.text.substring(0, _charCountAnimation.value);
        return Text(
          displayedText,
          style:  TextStyle(
            fontWeight: FontWeight.bold,
            color: widget.color,
            fontSize: widget.size,
          ),
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
