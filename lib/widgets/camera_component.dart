import 'package:charity/constant/my_colors.dart';
import 'package:flutter/material.dart';

class CameraComponent extends StatelessWidget {
  final String text ;
  final Function() onTap;
  const CameraComponent({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15.0,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0,),
          color: MyColors.myWhile,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(8, 8),
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Column(
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              size: 40.0,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
