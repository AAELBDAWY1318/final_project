import 'package:charity/constant/my_colors.dart';
import 'package:charity/size.dart';
import 'package:charity/widgets/my_custom_conditional_builder.dart';
import 'package:flutter/material.dart';

class CaseComponent extends StatelessWidget {
  final String title, description;
  final String? imageUrl;
  final double collectedAmount, allAmount;
  final Function()? onTap;
  const CaseComponent(
      {super.key,
      this.imageUrl,
      this.onTap,
      required this.title,
      required this.description,
      required this.collectedAmount,
      required this.allAmount});

  @override
  Widget build(BuildContext context) {
    double progressValue = 0.0;
    if (collectedAmount > 0.0) {
      progressValue = collectedAmount / allAmount;
    }
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: sizeConfig.screenWidth! * 0.95,
        height: sizeConfig.screenHeight! * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
          border: Border.all(
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: MyColors.myWhile,
              blurRadius: 20.0,
              offset: const Offset(8, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyConditionalBuilder(
              condition: (imageUrl != null),
              whenTrueCondition: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      height: sizeConfig.screenHeight! * 0.2,
                      width: sizeConfig.screenWidth! * 0.95,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(), // Or any other placeholder widget
              whenFalseCondition: Image.asset(
                'assets/images/myLogo.png',
                height: sizeConfig.screenHeight! * 0.2,
                width: sizeConfig.screenWidth! * 0.95,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 17.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: LinearProgressIndicator(
                value: progressValue,
                color: MyColors.myBlue,
              ),
            ),
            const SizedBox(
                height: 4), // Add space between title and description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '$collectedAmount / $allAmount',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
