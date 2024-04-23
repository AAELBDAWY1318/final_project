import 'dart:developer';
import 'dart:io';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/request_bloc/request_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/camera_component.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:request_repository/request_repository.dart';
import 'package:path/path.dart';

class ApplyRequestScreen extends StatelessWidget {
  const ApplyRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    TextEditingController nameController = TextEditingController();
    TextEditingController idController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String imagePath1 = '', imagePath2 = '';
    return BlocProvider(
      create: (context) =>
          RequestBloc(requestRepository: FirebaseRequestRepository()),
      child: BlocConsumer<RequestBloc, RequestState>(
        listener: (context, state) {
          if(state is AddRequestProcess){
            showDialog(
              context: context,
              builder: (context){
                return const AlertDialog(
                  content: CircularProgressIndicator(),
                );
              }
            );
          }else if (state is AddRequestFailure){
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Image.asset('assets/images/failure.png'),
                    actions: [
                      TextButton(
                        child: const Icon(Icons.done),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
            );
          }else if(state is AddRequestSuccess){
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Image.asset('assets/images/success.png'),
                    actions: [
                      TextButton(
                        child: const Icon(Icons.done),
                        onPressed: (){
                          Navigator.pop(context);
                          nameController.text='';
                          imagePath2='';
                          imagePath1='';
                          descriptionController.text ='';
                          idController.text ='';
                          phoneController.text ='';

                        },
                      ),
                    ],
                  );
                }
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
                        SecondDefaultText(text: getLang(context, "apply app")!),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DefaultTextFormField(
                          icon: Icons.person,
                          label: getLang(context, "Name")!,
                          controller: nameController,
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return getLang(
                                  context, "This field must be assigned")!;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DefaultTextFormField(
                          icon: Icons.credit_card_outlined,
                          label: getLang(context, "id")!,
                          controller: idController,
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return getLang(
                                  context, "This field must be assigned")!;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DefaultTextFormField(
                          icon: Icons.phone,
                          label: getLang(context, "phone")!,
                          controller: phoneController,
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return getLang(
                                  context, "This field must be assigned")!;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DefaultTextFormField(
                          icon: Icons.description,
                          label: getLang(context, "description")!,
                          controller: descriptionController,
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return getLang(
                                  context, "This field must be assigned")!;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CameraComponent(
                                text: getLang(context, 'id face')!,
                                onTap: () async {
                                  var imagePicker = ImagePicker();
                                  var pickedImage = await imagePicker.pickImage(
                                    source: ImageSource.camera,
                                  );
                                  if (pickedImage != null) {
                                    imagePath1 = pickedImage.path;
                                  }
                                }),
                            CameraComponent(
                              text: getLang(context, 'id tail')!,
                              onTap: () async {
                                var imagePicker = ImagePicker();
                                var pickedImage = await imagePicker.pickImage(
                                  source: ImageSource.camera,
                                );
                                if (pickedImage != null) {
                                  imagePath2 = pickedImage.path;
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DefaultMaterialButton(
                          textColor: Colors.white,
                          buttonColor: MyColors.myBlue,
                          text: getLang(context, "Continue")!,
                          function: () {
                            if(formKey.currentState!.validate()){
                              if(imagePath1.isEmpty || imagePath2.isEmpty){
                                showDialog(
                                    context: context,
                                  builder: (context)=>AlertDialog(
                                    icon: const Icon(Icons.error_outline, color:Colors.red ,),
                                    content: Text(getLang(context, 'id')!),
                                  ),
                                );
                              }else{
                                Request request = Request(
                                  idImage1: imagePath1,
                                  idImage2: imagePath2,
                                  status: 'inQueue',
                                  description: descriptionController.text,
                                  phone: phoneController.text,
                                  nationalId: idController.text,
                                  name: nameController.text,
                                );
                                context.read<RequestBloc>().add(
                                  AddRequestRequired(request: request),
                                );
                              }
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
