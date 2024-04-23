import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/complaint_bloc/complaint_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:complaint_repository/complaint_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Suggestion extends StatelessWidget {
  const Suggestion({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    AppLocale.of(context).loadLang();
    return BlocProvider<ComplaintBloc>(
      create: (context) =>
          ComplaintBloc(complaintRepository: FirebaseComplaintRepository()),
      child: BlocConsumer<ComplaintBloc, ComplaintState>(
        listener: (context, state) {
          if(state is AddComplaintSuccess){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    content: Image.asset('assets/images/success.png'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          titleController.text= '';
                          descriptionController.text ='';
                          phoneController.text = '';
                        },
                        child: Text(getLang(context, "OK")!),
                      ),
                    ],
                  );
                },
            );
          }else if(state is AddComplaintFailure){
            showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  backgroundColor: Colors.white,
                  content: Image.asset('assets/images/failure.png'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
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
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Back(),
                        SecondDefaultText(text: getLang(context, "connect")!),
                        const SizedBox(height: 15.0,),
                        DefaultTextFormField(
                          controller: titleController,
                          label: getLang(context, "title")!,
                          icon: Icons.title,
                          validator: (String ? val) {
                            if (val!.isEmpty) {
                              return getLang(
                                  context, "This field must be assigned")!;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15.0,),
                        DefaultTextFormField(
                          controller: phoneController,
                          label: getLang(context, "phone")!,
                          icon: Icons.phone,
                          validator: (String ? val) {
                            if (val!.isEmpty) {
                              return getLang(
                                  context, "This field must be assigned")!;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15.0,),
                        DefaultTextFormField(
                          controller: descriptionController,
                          label: getLang(context, "description")!,
                          icon: Icons.description,
                          validator: (String ? val) {
                            if (val!.isEmpty) {
                              return getLang(
                                  context, "This field must be assigned")!;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15.0,),
                        DefaultMaterialButton(
                          text: getLang(context, 'Continue')!,
                          buttonColor: MyColors.myBlue,
                          textColor: Colors.white,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              final complaint = Complaint(
                                userId: '',
                                title: titleController.text,
                                description: descriptionController.text,
                                phone: phoneController.text,
                              );
                              context.read<ComplaintBloc>().add(
                                AddComplaint(complaint: complaint),
                              );
                            }
                          },
                        ),
                      ],
                    ),
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
