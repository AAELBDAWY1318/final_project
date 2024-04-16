import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final Function() function;
  const DefaultElevatedButton({
    super.key,
    required this.icon,
    required this.function,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
      ),
      onPressed: function,
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
