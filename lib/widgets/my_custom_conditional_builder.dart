import 'package:flutter/material.dart';

class MyConditionalBuilder extends StatelessWidget {
  final bool condition;
  final Widget whenTrueCondition;
  final Widget whenFalseCondition;
  const MyConditionalBuilder(
      {super.key,
      required this.condition,
      required this.whenTrueCondition,
      required this.whenFalseCondition});

  @override
  Widget build(BuildContext context) {
    if(condition){
      return whenTrueCondition;
    }else {
      return whenFalseCondition;
    }
  }
}
