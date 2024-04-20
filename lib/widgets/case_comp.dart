import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CaseComponent extends StatelessWidget {
  final String title;
  final String description;
  final double indicatorValue;
  final String image;
  final String text;
  final double get, all;
  final Function() onTap; // for component
  final Function() onPress; // for button
  const CaseComponent({
    super.key,
    required this.title,
    required this.description,
    required this.indicatorValue,
    required this.image,
    required this.get,
    required this.all,
    required this.onTap,
    required this.onPress,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: sizeConfig.screenWidth! * 0.75,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          border: Border.all(
            color: Colors.black, // Stroke color
            width: 2, // Stroke width
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: sizeConfig.screenHeight! * 0.13,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    maxLines: 1, // Limit to 1 line
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                      height: 4), // Add space between title and description
                  Text(
                    description,
                    maxLines: 1, // Limit to 1 line
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: indicatorValue,
                    color: const Color(0xFF2352A1),
                  ),
                  const SizedBox(
                      height: 4), // Add space between title and description
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '$get / $all ',
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFF2352A1)),
                        ),
                        onPressed: onPress,
                        child: Text(
                          text,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
