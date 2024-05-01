
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/home_screen/all_cases_frame.dart';
import 'package:charity/screens/home_screen/custom_campaign_fram.dart';
import 'package:charity/screens/home_screen/debtors_cases_frame.dart';
import 'package:charity/screens/home_screen/poor_cases_frame.dart';
import 'package:charity/screens/home_screen/students_cases_frame.dart';
import 'package:charity/screens/home_screen/widows_cases_frame.dart';
import 'package:charity/widgets/category_component.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    List<Widget> frames = [
      const AllCasesFrame(),
      const PoorCasesFrame(),
      const WidowsCasesFrame(),
      const StudentsCasesFrame(),
      const DebtorsCasesFrame(),
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomCampaignFrame(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SecondDefaultText(text: getLang(context, "Cases")!),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryComponent(
                      color: index ==0 ? MyColors.myBlue : MyColors.myWhile,
                      text: getLang(context, "All")!,
                      textColor: index == 0 ? Colors.white : Colors.black,
                      function: (){
                        setState(() {
                          index = 0;
                        });
                      }),
                  const SizedBox(width: 5.0,),
                  CategoryComponent(
                      color: index ==1 ? MyColors.myBlue : MyColors.myWhile,
                      text: getLang(context, "Poor")!,
                      textColor: index == 1 ? Colors.white : Colors.black,
                      function: (){
                        setState(() {
                          index = 1;
                        });
                      }),
                  const SizedBox(width: 5.0,),
                  CategoryComponent(
                      color: index ==2 ? MyColors.myBlue : MyColors.myWhile,
                      text: getLang(context, "Widows")!,
                      textColor: index == 2 ? Colors.white : Colors.black,
                      function: (){
                        setState(() {
                          index = 2;
                        });
                      }),
                  const SizedBox(width: 5.0,),
                  CategoryComponent(
                      color: index ==3 ? MyColors.myBlue : MyColors.myWhile,
                      text: getLang(context, "Students")!,
                      textColor: index == 3 ? Colors.white : Colors.black,
                      function: (){
                        setState(() {
                          index = 3;
                        });
                      }),
                  const SizedBox(width: 5.0,),
                  CategoryComponent(
                      color: index ==4 ? MyColors.myBlue : MyColors.myWhile,
                      text: getLang(context, "Debtors")!,
                      textColor: index == 4 ? Colors.white : Colors.black,
                      function: (){
                        setState(() {
                          index = 4;
                        });
                      }),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: frames[index],
          ),
        ],
      ),
    );
  }
}
