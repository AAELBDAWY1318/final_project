import 'dart:io';

import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/size.dart';
import 'package:flutter/material.dart';

class ShowImageFile extends StatelessWidget {
  final File file;

  const ShowImageFile({super.key, required this.file,});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Image.file(file),
            actions: [
              TextButton(
                child: Text(getLang(context, "OK")!),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: sizeConfig.screenWidth! * 0.3,
        height: sizeConfig.screenHeight! * 0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(8, 8),
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Image.file(file,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
