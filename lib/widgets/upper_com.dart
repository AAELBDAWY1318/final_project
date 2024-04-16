import 'package:charity/constant/my_colors.dart';
import 'package:charity/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpperComponent extends StatelessWidget {
  const UpperComponent({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return Container(
      color: MyColors.myBlue,
      width: double.infinity,
      height: sizeConfig.screenHeight! * 0.3,
      child: Column(
        children:
        [
          Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
            height: sizeConfig.screenHeight! * 0.25,
          ),
          Container(
            width: double.infinity,
            height: sizeConfig.screenHeight! * 0.05,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              )
            ),
          ),
        ],
      ),
    );
  }
}
