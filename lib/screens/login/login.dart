import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:charity/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/sign_up/sign_up.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:charity/widgets/first_default_text.dart';
import 'package:charity/widgets/upper_com.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/app_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(
        userRepository: context.read<AuthenticationBloc>().userRepository,
      ),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AppLayout()),
            );
          } else if (state is SignInFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(getLang(context, "Sign In Error")!),
                  content: Text(state.message ?? "Unknown error occurred"),
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
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const UpperComponent(),
                    FirstDefaultText(
                      text: getLang(context, 'Login')!,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultTextFormField(
                      controller: emailController,
                      icon: Icons.alternate_email,
                      label: getLang(context, "Enter Your Email")!,
                      validator: (val) {
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultTextFormField(
                      controller: passwordController,
                      icon: Icons.lock,
                      label: getLang(context, "Enter Your Password")!,
                      validator: (val) {
                        return null;
                      },
                      secure: true,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultTextButton(
                      text: getLang(context, "Forget Password ?")!,
                      function: () {},
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultMaterialButton(
                      text: getLang(context, "Login")!,
                      textColor: Colors.white,
                      buttonColor: MyColors.myBlue,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          context.read<SignInBloc>().add(
                                SignInRequired(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultTextButton(
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                        );
                      },
                      text: getLang(context, "Create A New Account")!,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultMaterialButton(
                      text: getLang(context, "Login As Admin")!,
                      textColor: Colors.black,
                      buttonColor: MyColors.myWhile,
                      function: () {},
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultMaterialButton(
                      text: getLang(context, "continue As Visitor")!,
                      textColor: Colors.black,
                      buttonColor: MyColors.myWhile,
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AppLayout()),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
