import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/cases_campaigns_bloc/cases_campaigns_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/camera_component.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddCampaignScreen extends StatelessWidget {
  const AddCampaignScreen({super.key});

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
                return AlertDialog(
                  content: CircularProgressIndicator(
                    color: MyColors.myBlue,
                  ),
                );
              },
            );
          }else if(state is AddCampaignFailure){
            showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Image.asset('assets/images/failure.png'),
                  actions: [
                    TextButton(
                      child:
                      Text(getLang(context, "OK")!),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          }else if(state is AddCampaignSuccess){
            showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Image.asset('assets/images/success.png'),
                  actions: [
                    TextButton(
                      child:
                      Text(getLang(context, "OK")!),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          }else if(state is AddCampaignFailureNetwork){
            showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Image.asset('assets/images/failure.png')),
                        Expanded(
                          child: Text(
                            getLang(context, "internet")!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
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
                        Navigator.pop(context);
                      },
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
                        SecondDefaultText(
                            text: getLang(context, "add campaign")!),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: CameraComponent(
                            text: getLang(context, "sImage")!,
                            onTap: () async {
                              var imagePicker = ImagePicker();
                              pickedImage = await imagePicker.pickImage(
                                source: ImageSource.gallery,
                              );
                            },
                          ),
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
                              if (pickedImage != null) {
                                CampaignModel campaignModel = CampaignModel(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    photo: pickedImage!.path,
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
