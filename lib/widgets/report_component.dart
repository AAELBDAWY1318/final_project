import 'package:charity/size.dart';
import 'package:charity/widgets/animated_container_with_text.dart';
import 'package:flutter/material.dart';

class ReportComponent extends StatelessWidget {
  final String text ;
  final Function() ?  onTap;
  const ReportComponent({super.key, required this.text , this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return GestureDetector(
      onTap: onTap ?? (){},
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(8, 8),
                  blurRadius: 20.0,
                  color: Colors.grey,
                ),
              ],
            ),
            height: sizeConfig.screenHeight! *0.1,
            width: sizeConfig.screenWidth! * 0.2,
            child: Image.asset(
              'assets/images/myLogo.png',
            ),
          ),
          AnimatedTextContainer(text: text),
        ],
      ),
    );
  }
}
