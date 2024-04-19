import 'package:charity/size.dart';
import 'package:flutter/material.dart';

class CategoryComponent extends StatelessWidget {
  final Color color;
  final String text;
  final Color textColor;
  final Function() function;
  const CategoryComponent({
    super.key,
    required this.color,
    required this.text,
    required this.textColor,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        height: sizeConfig.screenWidth! * 0.07,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
