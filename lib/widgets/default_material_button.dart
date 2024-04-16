import 'package:flutter/material.dart';

class DefaultMaterialButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final Function() function;
  final Color textColor;
  const DefaultMaterialButton({
    super.key,
    required this.buttonColor,
    required this.text,
    required this.function,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10.0,),
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10.0,
              color: Colors.grey,
              offset: Offset(8, 8),
            ),
          ]
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
         text,
          style: TextStyle(
            color: textColor,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
