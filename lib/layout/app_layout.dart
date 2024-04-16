
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/donate_screen/donate_screen.dart';
import 'package:charity/screens/home_screen/home_screen.dart';
import 'package:charity/screens/list_screen/list_screen.dart';
import 'package:charity/widgets/default_evevated_button.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  List<Widget> screens = [HomeScreen(), DonateScreen(), ListScreen()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DefaultElevatedButton(
              color: index == 0 ? MyColors.myBlue : MyColors.myWhile,
              icon: Icons.home,
              iconColor: index == 0 ? Colors.white : Colors.black,
              function: () {
                index = 0;
                setState(() {});
              },
            ),
            DefaultElevatedButton(
              color: index == 1 ? MyColors.myBlue : MyColors.myWhile,
              icon: Icons.monetization_on,
              iconColor: index == 1 ? Colors.white : Colors.black,
              function: () {
                index = 1;
                setState(() {});
              },
            ),
            DefaultElevatedButton(
              color: index == 2 ? MyColors.myBlue : MyColors.myWhile,
              icon: Icons.list,
              iconColor: index == 2 ? Colors.white : Colors.black,
              function: () {
                index = 2;
                setState(() {});
              },
            ),
          ],
        ),
      ),
      body: screens[index],
    );
  }
}
