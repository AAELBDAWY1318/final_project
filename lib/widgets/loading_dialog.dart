import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/animated_loading.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LoadingAnimation(),
          Text(
            getLang(context, "waiting")!,
            style: TextStyle(
              color: MyColors.myBlue,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
