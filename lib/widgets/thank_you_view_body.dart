import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/custom_dashed_line.dart';
import 'package:charity/widgets/thank_you_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThankYouViewBody extends StatelessWidget {
  const ThankYouViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const ThankYouCard(),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height * 0.2 + 20,
            left: 20 + 8,
            right: 20 + 8,
            child: const CustomDashedLine(),
          ),
          Positioned(
              left: -20,
              bottom: MediaQuery.sizeOf(context).height * 0.2,
              child: CircleAvatar(
                backgroundColor: MyColors.myWhile,
              )),
          Positioned(
              right: -20,
              bottom: MediaQuery.sizeOf(context).height * 0.2,
              child: CircleAvatar(
                backgroundColor: MyColors.myWhile,
              )),
          const Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 38,
                backgroundColor: Colors.green,
                child: Icon(Icons.check, size: 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
