import 'package:flutter/material.dart';

class SecondDefaultText extends StatelessWidget {
  final String text;
  const SecondDefaultText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
