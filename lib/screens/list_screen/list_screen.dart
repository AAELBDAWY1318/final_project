import 'dart:developer';

import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:charity/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:charity/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:charity/screens/about_us_screen/about_us_screen.dart';
import 'package:charity/screens/dashboard_screen/dashboard_screen.dart';
import 'package:charity/screens/login/login.dart';
import 'package:charity/screens/logout/logout.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/list_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/scr/models/user.dart';
import '../../constant/my_colors.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    log('$user');
    if(user != null){
      // Provide the MyUserBloc to the widget tree
      return BlocProvider<MyUserBloc>(
        create: (context) => MyUserBloc(
          myUserRepository: context.read<AuthenticationBloc>().userRepository,
        )..add(GetMyUser(
            myUserId: user!.uid)), // Dispatch an event to fetch user data when bloc is created
        child: BlocBuilder<MyUserBloc, MyUserState>(
          builder: (context, state) {
            if (state.status == MyUserStatus.success) {
              // User data has been loaded, build the UI with user information
              return _buildListScreen(context, state.user!);
            } else {
              // User data is loading or not available, show a loading indicator or placeholder
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      );
    }else{
      return _buildListScreen(context , MyUser(
        userId: '',
        email: '',
        name: 'Visitor',
        flag: 'visitor'
      ));
    }
  }

  Widget _buildListScreen(BuildContext context, MyUser user) {
    // Build your UI here using the user data
    AppLocale.of(context).loadLang(); // load the languages
    String name = user.name; // Assuming User has a 'name' property
    String buildFlag = user.flag!; // Assuming this value is determined elsewhere
    List<Widget> list = preBuilding(context, name, buildFlag , user.email);
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15.0,
        right: 15.0,
        left: 15.0,
        top: 50.0,
      ),
      child: ListView.separated(
        itemCount: list.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 10.0,
        ),
        itemBuilder: (context, index) => list[index],
      ),
    );
  }

  List<Widget> preBuilding(BuildContext context, String name, String buildFlag , String email) {
    //this list hold the component for all (user , admin , visitor)
    // this also can be the admin operation list
    // as it hold all operation
    List<ListComponent> listComponents = [
      ListComponent(
        text: getLang(context, 'about us')!,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutUsScreen()),
          );
        },
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashBoardScreen()),
          );
        },
      ),
      ListComponent(
        text: getLang(context, 'change lang')!,
        onTap: () {},
      ),
      ListComponent(
        text: getLang(context, 'logout')!,
        onTap: () {
          Navigator.push(context, 
            MaterialPageRoute(builder: (context) => Logout(email: email))
          );
        },
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
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
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
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF2352A1)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
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
