import 'dart:developer';

import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/request_bloc/request_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:charity/widgets/first_default_text.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:charity/widgets/upper_com.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_repository/request_repository.dart';

class AskAboutRequestScreen extends StatelessWidget {
  const AskAboutRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    TextEditingController idController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocProvider<RequestBloc>(
      create: (context) =>
          RequestBloc(requestRepository: FirebaseRequestRepository()),
      child: BlocConsumer<RequestBloc, RequestState>(
        listener: (context, state) {
          if(state is AskAboutRequestProcess){
            showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: CircularProgressIndicator(
                    color: MyColors.myBlue,
                  ),
                );
              }
            );
          }else if (state is AskAboutRequestFailure){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Image.asset('assets/images/failure.png'),
                    actions: [
                      TextButton(
                        child: Text(getLang(context, "OK")!),
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
            );
          }else if(state is AskAboutRequestSuccess){
            idController.text='';
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: SecondDefaultText(
                      text: getLang(context, state.response)!,
                    ),
                    actions: [
                      TextButton(
                        child: Text(getLang(context, "OK")!),
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
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
                        text: getLang(context, "ask about request")!),
                    const SizedBox(
                      height: 20.0,
                    ),
                    DefaultTextFormField(
                      label: getLang(context, 'id')!,
                      icon: Icons.credit_card_outlined,
                      controller: idController,
                      validator: (String? val) {
                        if (val!.length < 14) {
                          return getLang(context, "id length")!;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DefaultMaterialButton(
                      buttonColor: MyColors.myBlue,
                      textColor: Colors.white,
                      text: getLang(context, "Continue")!,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          context.read<RequestBloc>().add(
                                AskAboutRequest(nationalId: idController.text),
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
