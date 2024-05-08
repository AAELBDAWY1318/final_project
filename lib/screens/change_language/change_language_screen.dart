import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/language_bloc/language_bloc.dart';
import 'package:charity/main.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/change_language_component.dart';
import 'package:charity/widgets/failure_dialog.dart';
import 'package:charity/widgets/loading_dialog.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:charity/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/scr/firebase_user_repos.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageBloc>(
      create: (context) => LanguageBloc(),
      child: BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, state) {
          if (state is ChangeLanguageFailure) {
            showDialog(
              context: context,
              builder: (context) => FailureDialog(onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              }),
            );
          } else if (state is ChangeLanguageProcess) {
            showDialog(
              context: context,
              builder: (context) => const LoadingDialog(),
            );
          } else if (state is ChangeLanguageSuccess) {
            showDialog(
              context: context,
              builder: (context) => SuccessDialog(onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(FirebaseUserRepos(),
                        defaultLanguageCode: state.languageCode),
                  ),
                  (route) => false, // Remove all routes until the new route
                );
              }),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Back(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SecondDefaultText(
                        text: getLang(context, "lang")!,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ChangeLanguageComponent(
                        text: "العربية",
                        image: "assets/images/arab.png",
                        onTap: () {
                          context.read<LanguageBloc>().add(ChangeLanguageEvent(
                              AppLocale.of(context),
                              languageCode: 'ar'));
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ChangeLanguageComponent(
                        text: "English",
                        image: "assets/images/english.png",
                        onTap: () {
                          context.read<LanguageBloc>().add(ChangeLanguageEvent(
                              AppLocale.of(context),
                              languageCode: 'en'));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
