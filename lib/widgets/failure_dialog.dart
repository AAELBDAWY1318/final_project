import 'package:charity/app_locale/app_locale.dart';
import 'package:flutter/material.dart';

class FailureDialog extends StatelessWidget {
  final Function() onPressed;
  const FailureDialog({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/failure.png',
            height: 100.0,
          ),
          Text(
            getLang(context, "failure")!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          child: Text(getLang(context,  "OK")!),
        ),
      ],
    );
  }
}
