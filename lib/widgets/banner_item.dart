import 'package:flutter/material.dart';

class BannerItem extends StatelessWidget {
  final String image , text;
  const BannerItem({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.center,
      children: [
        Container(
          //height:200.0,
          width:double.infinity,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Image.asset(
           image,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize:22.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
