import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:charity/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/login/login.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:charity/widgets/first_default_text.dart';
import 'package:charity/widgets/upper_com.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    AppLocale.of(context).loadLang();
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(
        userRepository: context.read<AuthenticationBloc>().userRepository,
      ),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if(state is SendResetPasswordSuccess){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(getLang(context , "Reset Password")!),
                  content: Text(getLang(context, "Verification send")!),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context)=> LoginScreen()),
                        );
                      },
                      child: Text(getLang(context,  "OK")!),
                    ),
                  ],
                );
              },
            );

          }else if(state is SendResetPasswordFailure){
            String message = state.message ?? "unknown";
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(getLang(context , "error")!),
                  content: Text(getLang(context, message)!),
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

          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const UpperComponent(),
                    FirstDefaultText(
                      text: getLang(context, "Reset Password")!,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultTextFormField(
                      label: getLang(context, "Enter Your Email")!,
                      icon: Icons.alternate_email,
                      controller: emailController,
                      validator: (String? val) {
                        // Regular expression for email validation
                        final RegExp emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (val!.isEmpty) {
                          return getLang(
                              context, "This field must be assigned");
                        } else if (!emailRegex.hasMatch(val)) {
                          return getLang(
                              context, "You must assign a valid email");
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultMaterialButton(
                      text: getLang(context, "Continue")!,
                      buttonColor: MyColors.myBlue,
                      textColor: Colors.white,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          context.read<SignInBloc>().add(
                            SendResetPassword(email: emailController.text),
                          );
                        }
                      },
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
