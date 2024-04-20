import 'package:charity/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:charity/screens/home_screen/home_screen.dart';
import 'package:charity/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_locale/app_locale.dart';
import 'layout/app_layout.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc , AuthenticationState>(
        builder: (context , state){
          if(state.status == AuthenticationStatus.authenticated){
            return AppLayout();
          }else{
            return LoginScreen();
          }
        },
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocale.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''),
        Locale('en', ''),
      ],
      localeResolutionCallback: (currentLang, supportLang) {
        if (currentLang == null) {
          for (Locale locale in supportLang) {
            if (locale.languageCode == currentLang!.languageCode) {
              return currentLang;
            }
          }
        }
        return supportLang.first;
      },
    );
  }
}
