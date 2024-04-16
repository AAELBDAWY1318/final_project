import 'package:flutter/material.dart';

class FirstDefaultText extends StatelessWidget {
  final String text;
  const FirstDefaultText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
