import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final Function() function;
  final bool flag;
  final String text;
  const DefaultElevatedButton({
    super.key,
    required this.icon,
    required this.function,
    required this.color,
    required this.iconColor,
    this.flag = false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          Visibility(
            visible: flag,
            child: Text(text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
