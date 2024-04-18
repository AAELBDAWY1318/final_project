import 'dart:developer';

import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:charity/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:charity/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/scr/models/models.dart';

import '../../constant/my_colors.dart';
import '../../widgets/default_material_button.dart';
import '../../widgets/default_text_button.dart';
import '../../widgets/default_text_form_field.dart';
import '../../widgets/first_default_text.dart';
import '../../widgets/upper_com.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    // BlocProvider to create the BLoc
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
        // just we create user Repository in Authentication Bloc
        // send it to SignUp Bloc
          userRepository: context.read<AuthenticationBloc>().userRepository,
      ),
      // we use BlocConsumer because it like combine
      // between listener and builder
      // we need to listen and build
      child: BlocConsumer<SignUpBloc , SignUpState>(
        //listen to state
        listener: (context, state) {
          if (state is SignUpFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(getLang(context , "Sign Up Error")!),
                  content: Text(state.message ?? "Unknown error occurred"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(getLang(context,  "OK")!),
                    ),
                  ],
                );
              },
            );
          } else if(state is SignUpSuccess){
            context.read<SignUpBloc>().add(
              SendVerificationLink(),
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(getLang(context , "Verification")!),
                  content: Text(getLang(context, "Verification send")!),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      },
                      child: Text(getLang(context,  "OK")!),
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context , state){
          return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const UpperComponent(),
                    FirstDefaultText(
                      text: getLang(context, 'SignUp')!,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultTextFormField(
                      controller: nameController,
                      icon: Icons.person,
                      label: getLang(context, "Name")!,
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return getLang(context, "This field must be assigned");
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultTextFormField(
                      controller: emailController,
                      icon: Icons.alternate_email,
                      label: getLang(context, "Enter Your Email")!,
                      validator: (String? val) {
                        // Regular expression for email validation
                        final RegExp emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (val!.isEmpty) {
                          return getLang(context, "This field must be assigned");
                        } else if (!emailRegex.hasMatch(val)) {
                          return getLang(context, "You must assign a valid email");
                        }
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
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return getLang(context, "This field must be assigned");
                        } else if (val!.length < 8) {
                          return getLang(context,
                              "The email must be more than or equal to 8 chars");
                        }
                        return null;
                      },
                      secure: true,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultMaterialButton(
                      text: getLang(context, "Continue")!,
                      textColor: Colors.white,
                      buttonColor: MyColors.myBlue,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          MyUser myUser = MyUser.empty;
                          myUser = myUser.copyWith(
                            email: emailController.text,
                            name: nameController.text,
                          );
                          context.read<SignUpBloc>().add(
                              SignUpRequired(
                                  myUser,
                                  passwordController.text
                              ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultTextButton(
                      function: () {},
                      text: getLang(context, "Login")!,
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
