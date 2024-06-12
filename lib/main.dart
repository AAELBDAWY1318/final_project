 import 'dart:io';

import 'package:charity/appview.dart';
import 'package:charity/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:charity/dio_helper/dio_helper.dart';
import 'package:charity/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/scr/firebase_user_repos.dart';
import 'package:user_repository/scr/user_repos.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ensure that every thing initialized
  await DioHelper.init();
  // get instance from shared preference
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // initialize default language code if it null by default it will be english
  String defaultLanguageCode = prefs.getString('lang') ?? 'en'; // Default language code
  //initialize firebase by it's options
  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid
        ? const FirebaseOptions(
      apiKey: "AIzaSyA17IeuxOBHRalXD7apwayyAuXUAQZquOw",
      appId: "AIzaSyA17IeuxOBHRalXD7apwayyAuXUAQZquOw",
      messagingSenderId: "555327982230",
      projectId: "charity-3385e",
    ): null,
  );
  //observer follow the bloc to know what's state, and what's event i am in now
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepos(), defaultLanguageCode: defaultLanguageCode,));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final String defaultLanguageCode;

  const MyApp(this.userRepository, {super.key, required this.defaultLanguageCode});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: AppView(defaultLanguageCode: defaultLanguageCode,),
    );
  }
}
