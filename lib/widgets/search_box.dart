import 'package:charity/constant/my_colors.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final String text;
  final Function() onTap;
  const SearchBox({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          color: MyColors.myWhile,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0,
              offset: Offset(8, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Text(text),
            const Icon(Icons.search),
          ],
        ),
      ),
    );
  }
}
