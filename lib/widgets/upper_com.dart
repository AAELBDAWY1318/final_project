import 'package:charity/constant/my_colors.dart';
import 'package:charity/size.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpperComponent extends StatelessWidget {
  const UpperComponent({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children:
          [
            Container(
              color: MyColors.myBlue,
              width: double.infinity,
              child: Image.asset(
                'assets/images/logo.png',
                height: sizeConfig.screenHeight! * 0.25,
                width: 100.0,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: sizeConfig.screenHeight! * 0.05,
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: sizeConfig.screenHeight! * 0.085,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              )
          ),
        ),
      ],
    );
  }
}
