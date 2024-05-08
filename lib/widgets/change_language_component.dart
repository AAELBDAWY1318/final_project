import 'package:charity/constant/my_colors.dart';
import 'package:flutter/material.dart';

class ChangeLanguageComponent extends StatelessWidget {
  final String image, text;
  final Function() onTap;
  const ChangeLanguageComponent(
      {super.key,
      required this.image,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: MyColors.myWhile,
          borderRadius: BorderRadius.circular(50.0, ),
          border: Border.all(
            width: 1.0,
            color: Colors.grey,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(8, 8),
              blurRadius: 30.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 50.0,
            ),
            const SizedBox(width: 20.0,),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
