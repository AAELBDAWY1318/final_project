import 'dart:io';

import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/cases_campaigns_bloc/cases_campaigns_bloc.dart';
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

class AddCampaignScreen extends StatefulWidget {
  const AddCampaignScreen({super.key});

  @override
  State<AddCampaignScreen> createState() => _AddCampaignScreenState();
}
class _AddCampaignScreenState extends State<AddCampaignScreen> {
  String image = '';
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

  void showBottomSheet(BuildContext context){
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
                    image = imagePath;
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
                    image = imagePath;
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
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController moneyController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    XFile? pickedImage;
    return BlocProvider<CasesCampaignsBloc>(
      create: (context) => CasesCampaignsBloc(
          caseCampaignRepository: FirebaseCaseCampaignRepository()),
      child: BlocConsumer<CasesCampaignsBloc, CasesCampaignsState>(
        listener: (context, state) {
          if(state is AddCampaignProcess){
            showDialog(
              context: context,
              builder: (context){
                return const LoadingDialog();
              },
            );
          }else if(state is AddCampaignFailure){
            showDialog(
              context: context,
              builder: (context){
                return FailureDialog(onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
            );
          }else if(state is AddCampaignSuccess){
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context){
                return SuccessDialog(onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);

                });
              },
            );
          }else if(state is AddCampaignFailureNetwork){
            showDialog(
              context: context,
              builder: (context){
                return FailureDialog(onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
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
                        SecondDefaultText(
                            text: getLang(context, "add campaign")!),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: image.isEmpty?
                          CameraComponent(
                            text: getLang(context, "sImage")!,
                            onTap: () {
                              showBottomSheet(context);
                            },
                          ) :
                              ShowImageFile(file: File(image)),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        DefaultTextFormField(
                          controller: titleController,
                          label: getLang(context, "title")!,
                          icon: Icons.title,
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
                          controller: descriptionController,
                          label: getLang(context, "des")!,
                          icon: Icons.description,
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
                          keyboardType: TextInputType.number,
                          controller: moneyController,
                          label: getLang(context, "money")!,
                          icon: Icons.money_off,
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
                        DefaultMaterialButton(
                          text: getLang(context, "add")!,
                          textColor: Colors.white,
                          buttonColor: MyColors.myBlue,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              if (image.isNotEmpty) {
                                CampaignModel campaignModel = CampaignModel(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    photo: image,
                                    allAmount: moneyController.text,
                                    collectedAmount: '0.0');
                                context.read<CasesCampaignsBloc>().add(
                                    AddCampaignEvent(
                                        campaignModel: campaignModel));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Center(
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Image.asset(
                                                  'assets/images/uncomplete.png',
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  getLang(context, "sImage")!,
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child:
                                                Text(getLang(context, "OK")!),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
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
