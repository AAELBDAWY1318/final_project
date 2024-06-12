import 'dart:developer';
import 'dart:io';

import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/request_bloc/request_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/camera_component.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:charity/widgets/failure_dialog.dart';
import 'package:charity/widgets/loading_dialog.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:charity/widgets/show_image_file.dart';
import 'package:charity/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:request_repository/request_repository.dart';

class ApplyRequestScreen extends StatefulWidget {
  const ApplyRequestScreen({super.key});

  @override
  State<ApplyRequestScreen> createState() => _ApplyRequestScreenState();
}

class _ApplyRequestScreenState extends State<ApplyRequestScreen> {
  String imagePath1 = '', imagePath2 = '';
  // Function to select an image from gallery or camera
  Future<String> _pickImage(ImageSource source) async {
    String imagePath = '';
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        imagePath = pickedFile.path;
      }
    });
    return imagePath;
  }

  void showBottomSheet(BuildContext context , int index ){
    String imagePath = '';
    showModalBottomSheet(context: context,
        builder: (context){
          return Container(
            height: 150.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: MyColors.myBlue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () async{
                    imagePath = await _pickImage(ImageSource.camera);
                    index == 1 ? imagePath1 = imagePath : imagePath2 = imagePath;
                    log(imagePath);
                    setState(() {
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 50.0,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: ()async{
                    imagePath = await _pickImage(ImageSource.gallery);
                    index == 1 ? imagePath1 = imagePath : imagePath2 = imagePath;
                    log(imagePath);
                    setState(() {
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Icon(
                      Icons.photo,
                      size: 50.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    TextEditingController nameController = TextEditingController();
    TextEditingController idController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) =>
          RequestBloc(requestRepository: FirebaseRequestRepository()),
      child: BlocConsumer<RequestBloc, RequestState>(
        listener: (context, state) {
          if(state is AddRequestProcess){
            showDialog(
              context: context,
              builder: (context){
                return const LoadingDialog();
              }
            );
          }else if (state is AddRequestFailure){
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context){
                  return FailureDialog(onPressed: (){
                    Navigator.pop(context);
                  });
                }
            );
          }else if(state is AddRequestSuccess){
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context){
                  return SuccessDialog(onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
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
                            if (imagePath1.isEmpty) CameraComponent(
                                text: getLang(context, 'id face')!,
                                onTap: () {
                                  showBottomSheet(context, 1);
                                }) else ShowImageFile(file: File(imagePath1)),
                            imagePath2.isEmpty ?
                            CameraComponent(
                              text: getLang(context, 'id tail')!,
                              onTap: () {
                                showBottomSheet(context, 2);
                              },
                            ):ShowImageFile(file: File(imagePath2)),
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
                                  flag: 'real',
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
