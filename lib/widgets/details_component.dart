import 'package:flutter/material.dart';

class DetailsCom extends StatelessWidget {
  final String what , res;
  const DetailsCom({super.key, required this.what, required this.res});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$what : ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        Text(
          res,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.black45,
          ),
        ),
      ],
    );
  }
}
