import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/screens/login/login.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/list_component.dart';
import 'package:flutter/material.dart';
import '../../constant/my_colors.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang(); // load the languages
    String name = "User";
    String buildFlag = "admin";
    List<Widget> list = preBuilding(context, name, buildFlag);
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15.0,
        right: 15.0,
        left: 15.0,
        top: 50.0,
      ),
      child: ListView.separated(
        itemCount: list.length,
        separatorBuilder: (context , index)=>const SizedBox(height: 10.0,),
        itemBuilder: (context , index) => list[index],
      ),
    );
  }

  List<Widget> preBuilding(
      BuildContext context, String name, String buildFlag) {
    //this list hold the component for all (user , admin , visitor)
    // this also can be the admin operation list
    // as it hold all operation
    List<ListComponent> listComponents = [
      ListComponent(
        text: getLang(context, 'about us')!,
        onTap: () {},
      ),
      ListComponent(
        text: getLang(context, 'apply app')!,
        onTap: () {},
      ),
      ListComponent(
        text: getLang(context, 'connect')!,
        onTap: () {},
      ),
      ListComponent(
        text: getLang(context, 'ask about request')!,
        onTap: () {},
      ),
      ListComponent(
        text: getLang(context, 'my donation reports')!,
        onTap: () {},
      ),
      ListComponent(
        text: getLang(context, 'dashboard')!,
        onTap: () {},
      ),
      ListComponent(
        text: getLang(context, 'change lang')!,
        onTap: () {},
      ),
      ListComponent(
        text: getLang(context, 'logout')!,
        onTap: () {},
      ),
    ];
    // this hold only visitor operation
    List<ListComponent> visitorOperationList = [
      listComponents[0],
      listComponents[1],
      listComponents[2],
      listComponents[3],
    ];
    // this hold only donor operations
    List<ListComponent> donorOperationList = [
      listComponents[0],
      listComponents[1],
      listComponents[2],
      listComponents[3],
      listComponents[4],
      listComponents[6],
      listComponents[7],
    ];
    List<Container> topComponent = [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0, ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Stroke color
            width: 1, // Stroke width
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/person.png',
            ),
            Text(
              '${getLang(context, "welcome")}, $name',
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Stroke color
            width: 1, // Stroke width
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/person.png',
            ),
            Text(
              '${getLang(context, "welcome")}, $name',
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF2352A1)),
                ),
                onPressed: (){},
                child: Text(
                  getLang(context, 'Login')!,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
    final List<Widget>? listToUse;
    final List<Widget>? topToUse;
    if (buildFlag == "visitor") {
      listToUse = visitorOperationList;
      topToUse = [topComponent[1]];
    } else if (buildFlag == "admin") {
      listToUse = listComponents;
      topToUse = [topComponent[0]];
    } else {
      listToUse = donorOperationList;
      topToUse = [topComponent[0]];
    }
    List<Widget> list = topToUse + listToUse;
    return list;
  }
}
