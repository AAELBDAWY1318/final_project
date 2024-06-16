import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:charity/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/login/login.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/upper_com.dart';

class Logout extends StatelessWidget {
  final String email;

  const Logout({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    return BlocProvider<SignInBloc>(
      create: (context) =>
          SignInBloc(
            userRepository: context
                .read<AuthenticationBloc>()
                .userRepository,
          ),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignOutSuccess) {
            // Navigate to the login screen
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          } else if (state is SignOutFailure) {
            // Show error dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(getLang(context, "logout")!),
                  content: Text(getLang(context, "error")!),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(getLang(context, "OK")!),
                    ),
                  ],
                );
              },
            );
          } else if (state is SignOutSuccess){
            // Show loading dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const LoadingDialog();
              },
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  Column(
                    children: [
                      const UpperComponent(),
                      Text(
                        getLang(context, "are U sure")!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        email,
                      ),
                      const SizedBox(height: 15.0,),
                      DefaultMaterialButton(
                        textColor: Colors.white,
                        buttonColor: MyColors.myBlue,
                        text: getLang(context, 'Continue')!,
                        function: () {
                          context.read<SignInBloc>().add(
                            const SignOutRequired(),
                          );
                        },
                      ),
                    ],
                  ),
                  const Back(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
