import 'package:flutter/material.dart';

class CustomDashedLine extends StatelessWidget {
  const CustomDashedLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        25,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              color: Colors.black54,
              height: 2,
            ),
          ),
        ),
      ),
    );
  }
}
