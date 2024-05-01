import 'package:flutter/material.dart';

class SecondDefaultText extends StatelessWidget {
  final String text;
  final Color ? fontColor ;
  const SecondDefaultText({super.key, required this.text , this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: fontColor ?? Colors.black,
      ),
    );
  }
}
