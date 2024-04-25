import 'dart:developer';
import 'package:charity/screens/browse_requests/browes_requests.dart';
import 'package:flutter/material.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/browse_fake_request/browse_fake_request.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/category_component.dart';

class RequestLayout extends StatefulWidget {
  const RequestLayout({super.key}); // Corrected constructor syntax

  @override
  State<RequestLayout> createState() => _RequestLayoutState();
}

class _RequestLayoutState extends State<RequestLayout> {
  int index = 0;
  // Moved index variable to the state class to ensure it persists between build calls
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Back(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CategoryComponent(
                  textColor: index == 0 ? Colors.white : Colors.black,
                  color: index == 0 ? MyColors.myBlue : MyColors.myWhile,
                  // Corrected color constant name
                  text: getLang(context, 'request')!,
                  function: () {
                    setState(() {
                      index = 0;
                      log('$index');
                    });
                  },
                ),
                CategoryComponent(
                  textColor: index == 1 ? Colors.white : Colors.black,
                  color: index == 1 ? MyColors.myBlue : MyColors.myWhile,
                  // Corrected color constant name
                  text: getLang(context, 'fake')!,
                  function: () {
                    setState(() {
                      index = 1;
                      log('$index');
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: IndexedStack(
                index: index,
                children: const [
                  BrowseRequests(),
                  BrowseFakeRequests(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
