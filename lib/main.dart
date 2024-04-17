import 'package:charity/appview.dart';
import 'package:charity/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:charity/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/scr/firebase_user_repos.dart';
import 'package:user_repository/scr/user_repos.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA17IeuxOBHRalXD7apwayyAuXUAQZquOw",
      appId: "AIzaSyA17IeuxOBHRalXD7apwayyAuXUAQZquOw",
      messagingSenderId: "555327982230",
      projectId: "charity-3385e",
    ),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepos()));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp(this.userRepository, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child:AppView(),
    );
  }
}
// test gitHub commit


