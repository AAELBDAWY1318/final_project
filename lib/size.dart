import 'package:flutter/material.dart';

class SizeConfig {
  double? screenWidth;
  double? screenHeight;
  double? defaultSize;
  Orientation? orientation;

  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;
    defaultSize =
        orientation == Orientation.landscape ? screenWidth : screenHeight;
  }
}
