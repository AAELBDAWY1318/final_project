import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/charts_screen/charts_creen.dart';
import 'package:charity/screens/donate_screen/donate_screen.dart';
import 'package:charity/screens/improved_home_screen/improved_home_screen.dart';
import 'package:charity/screens/list_screen/list_screen.dart';
import 'package:charity/widgets/default_evevated_button.dart';
import 'package:flutter/material.dart';


class AppLayout extends StatefulWidget {
  const AppLayout({Key? key});

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  List<Widget> screens = [const ImprovedHomeScreen(), const DonateScreen(),const ListScreen() , const ChartsScreen()];
  int index = 0;
  bool flag1 = true , flag2 = false , flag3 = false , flag4 = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (index != 0) {
          // Navigate back to the home screen when back button is pressed on other screens
          setState(() {
            index = 0;
            flag1 = true ;
            flag2 = false;
            flag3 = false ;
            flag4 = false ;
          });
          return false; // Prevent the default back button behavior
        }
        return true; // Allow the default back button behavior on the home screen
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0,),
          decoration: BoxDecoration(
            color: MyColors.myBlue,
            borderRadius: BorderRadius.circular(20.0,),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DefaultElevatedButton(
                color: Colors.transparent,
                icon: Icons.home,
                iconColor: index == 0 ? Colors.white : Colors.grey,
                text: getLang(context , "home")!,
                flag: flag1,
                function: () {
                  setState(() {
                    index = 0;
                    flag1 = true ;
                    flag2 = false;
                    flag3 = false ;
                    flag4 = false ;
                  });
                },
              ),
              DefaultElevatedButton(
                color: Colors.transparent,
                icon: Icons.payment,
                iconColor: index == 1 ? Colors.white : Colors.grey,
                text: getLang(context , "donate")!,
                flag: flag2,
                function: () {
                  setState(() {
                    index = 1;
                    flag1 = false ;
                    flag2 = true;
                    flag3 = false ;
                    flag4 = false ;
                  });
                },
              ),
              DefaultElevatedButton(
                color: Colors.transparent,
                icon: Icons.bar_chart,
                iconColor: index == 3 ? Colors.white : Colors.grey,
                text: getLang(context , "charts")!,
                flag: flag4,
                function: () {
                  setState(() {
                    index = 3;
                    flag1 = false ;
                    flag2 = false;
                    flag3 = false ;
                    flag4 = true ;
                  });
                },
              ),
              DefaultElevatedButton(
                color: Colors.transparent,
                icon: Icons.list,
                iconColor: index == 2 ? Colors.white : Colors.grey,
                text: getLang(context , "more")!,
                flag: flag3,
                function: () {
                  setState(() {
                    index = 2;
                    flag1 = false ;
                    flag2 = false;
                    flag3 = true ;
                    flag4 = false;
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

