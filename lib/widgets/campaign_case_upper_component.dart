import 'package:charity/constant/my_colors.dart';
import 'package:charity/size.dart';
import 'package:charity/widgets/my_custom_conditional_builder.dart';
import 'package:flutter/material.dart';

class CampaignOrCaseUpperComponent extends StatelessWidget {
  final String ? imagePath;
  final String ? imageUrl;
  const CampaignOrCaseUpperComponent({super.key, this.imagePath, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(100.0),
                  bottomLeft: Radius.circular(100.0),
                ),
              ),
              child: MyConditionalBuilder(
                condition: (imageUrl != null),
                whenTrueCondition: imageUrl != null ? Image.network(
                  imageUrl!,
                  height:sizeConfig.screenHeight! * 0.3,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ) : const SizedBox(),
                whenFalseCondition:imagePath != null ? Image.asset(
                  imagePath!,
                  height:sizeConfig.screenHeight! * 0.3,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ) :  const SizedBox(),
              ),
            ),
            SizedBox(
              height: sizeConfig.screenHeight!*0.1,
            ),
          ],
        ),
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0,),
              boxShadow: [
                BoxShadow(
                  color: MyColors.myWhile,
                  offset: const Offset(5, 15),
                  blurRadius: 20.0,
                ),
              ]
          ),
          child: Image.asset(
            'assets/images/myLogo.png',
            height: sizeConfig.screenHeight! * 0.2,
            width: sizeConfig.screenWidth! * 0.3,
          ),
        ),
      ],
    );
  }
}
