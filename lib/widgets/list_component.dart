import 'package:flutter/material.dart';

class ListComponent extends StatelessWidget {
  final String text ;
  final Function() onTap ;
  BorderRadius ? border;
   ListComponent({
    super.key,
    required this.text,
    required this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 20.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Stroke color
            width: 1, // Stroke width
          ),
          borderRadius: border,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }
}
