import 'package:flutter/material.dart';
import 'dart:async';
class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  bool _showOpenEyes = true; // Variable to switch between red and blue logo
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Toggle between blue and red logo every second
    // while the loading state is active
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        _showOpenEyes = !_showOpenEyes;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer to prevent further calls to setState()
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoadingAnimation();
  }

  Widget _buildLoadingAnimation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: _showOpenEyes,
          child: Image.asset(
            'assets/images/right.png',
            width: 100,
            height: 100,
          ),
        ),
        Visibility(
          visible: !_showOpenEyes,
          child: Image.asset(
            'assets/images/left.png',
            width: 100,
            height: 100,
          ),
        ),
      ],
    );
  }
}
