import 'package:charity/constant/my_colors.dart';
import 'package:flutter/material.dart';

class payment_method_item extends StatelessWidget {
  const payment_method_item({
    super.key,
    required this.isActive,
    required this.image,
  });

  final bool isActive;
  final String image;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 100,
      height: 60,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.5, color: isActive ? MyColors.myBlue : Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: [
            BoxShadow(
              color: isActive ? MyColors.myBlue : MyColors.myWhile,
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ]),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: MyColors.myWhile),
          child: Center(
              child: Image.asset(
            image,
            height: 24,
            fit: BoxFit.scaleDown,
          ))),
    );
  }
}
