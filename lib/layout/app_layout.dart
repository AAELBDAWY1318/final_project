import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/donate_screen/donate_screen.dart';
import 'package:charity/screens/home_screen/home_screen.dart';
import 'package:charity/screens/list_screen/list_screen.dart';
import 'package:charity/widgets/default_evevated_button.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key});

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  List<Widget> screens = [HomeScreen(), DonateScreen(), ListScreen()];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (index != 0) {
          // Navigate back to the home screen when back button is pressed on other screens
          setState(() {
            index = 0;
          });
          return false; // Prevent the default back button behavior
        }
        return true; // Allow the default back button behavior on the home screen
      },
      child: Scaffold(
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
                  setState(() {
                    index = 0;
                  });
                },
              ),
              DefaultElevatedButton(
                color: index == 1 ? MyColors.myBlue : MyColors.myWhile,
                icon: Icons.monetization_on,
                iconColor: index == 1 ? Colors.white : Colors.black,
                function: () {
                  setState(() {
                    index = 1;
                  });
                },
              ),
              DefaultElevatedButton(
                color: index == 2 ? MyColors.myBlue : MyColors.myWhile,
                icon: Icons.list,
                iconColor: index == 2 ? Colors.white : Colors.black,
                function: () {
                  setState(() {
                    index = 2;
                  });
                },
              ),
            ],
          ),
        ),
        body: screens[index],
      ),
    );
  }
}

