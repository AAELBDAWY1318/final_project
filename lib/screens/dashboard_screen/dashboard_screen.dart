import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/layout/request_layout.dart';
import 'package:charity/screens/browse_requests/browes_requests.dart';
import 'package:charity/screens/cases_screen/cases_screen.dart';
import 'package:charity/widgets/dashboard_item.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/back_compoent.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    List<Widget> itemsList = [
      DashboardItem(
        text: getLang(context, 'request')!,
        image: 'assets/images/request.png',
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return const RequestLayout();
              }),
          );
        },
      ),
      DashboardItem(
        text: getLang(context, 'Cases')!,
        image: 'assets/images/cases.png',
        onTap: () {
          Navigator.push(context, 
            MaterialPageRoute(builder: (context)=> const CasesScreen())
          );
        },
      ),
      DashboardItem(
        text: getLang(context, "complaints")!,
        image: 'assets/images/suggest.png',
        onTap: () {},
      ),
      DashboardItem(
        text: getLang(context, "add campaign")!,
        image: 'assets/images/add.png',
        onTap: () {},
      ),
      DashboardItem(
        text: getLang(context, "result")!,
        image: 'assets/images/result.png',
        onTap: () {},
      ),
      DashboardItem(
        text: getLang(context, "complete cases")!,
        image: 'assets/images/complete.png',
        onTap: () {},
      ),
      DashboardItem(
        text: getLang(context, "manage campaign")!,
        image: 'assets/images/manage.png',
        onTap: () {},
      ),
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Back(),
                SecondDefaultText(text: getLang(context, 'dashboard')!, ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                  shrinkWrap: true, // Adjusts its size based on its children
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                  ),
                  itemCount: itemsList.length,
                  itemBuilder: (context, index) {
                    return itemsList[index];
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
