import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:charity/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/reset_password_screen/reset_password_screen.dart';
import 'package:charity/screens/sign_up/sign_up.dart';
import 'package:charity/widgets/animated_loading.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:charity/widgets/failure_dialog.dart';
import 'package:charity/widgets/first_default_text.dart';
import 'package:charity/widgets/loading_dialog.dart';
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
          if(state is SignInSuccess){
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context)=>const AppLayout()),
            );
          }else if(state is SignInFailure){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return FailureDialog(onPressed: (){
                  Navigator.pop(context);
                });
              },
            );
          }else if(state is SignInProcess){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return const LoadingDialog();
                }
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
                  children:
                  [
                    const UpperComponent(),
                    FirstDefaultText(
                      text: getLang(context, 'Login')!,
                    ),
                    const SizedBox(height: 10.0,),
                    DefaultTextFormField(
                      controller: emailController,
                      icon: Icons.alternate_email,
                      label: getLang(context, "Enter Your Email")!,
                      validator: (val) {
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
                    const SizedBox(height: 10.0,),
                    DefaultTextFormField(
                      controller: passwordController,
                      icon: Icons.lock,
                      label: getLang(context, "Enter Your Password")!,
                      validator: (val) {
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
                    const SizedBox(height: 10.0,),
                    DefaultTextButton(
                      text: getLang(context, "Forget Password ?")!,
                      function: () {
                        Navigator.push(
                          context ,
                          MaterialPageRoute(builder: (context)=>const ResetPasswordScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 10.0,),
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
                    const SizedBox(height: 10.0,),
                    DefaultTextButton(
                      function: () {
                        Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                        );
                      },
                      text: getLang(context, "Create A New Account")!,
                    ),
                    const SizedBox(height: 10.0,),
                    DefaultMaterialButton(
                      text: getLang(context, "continue As Visitor")!,
                      textColor: Colors.black,
                      buttonColor: MyColors.myWhile,
                      function: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const AppLayout()),
                        );
                      },
                    ),
                    const SizedBox(height: 10.0,),
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
