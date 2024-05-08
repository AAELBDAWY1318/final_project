import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/cases_campaigns_bloc/cases_campaigns_bloc.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:charity/widgets/failure_dialog.dart';
import 'package:charity/widgets/loading_dialog.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:charity/widgets/show_image_component.dart';
import 'package:charity/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/my_colors.dart';

class EditCampaignScreen extends StatelessWidget {
  final CampaignModel campaignModel;

  const EditCampaignScreen({super.key, required this.campaignModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController moneyController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    titleController.text = campaignModel.title;
    descriptionController.text = campaignModel.description;
    moneyController.text = campaignModel.allAmount;
    return BlocProvider<CasesCampaignsBloc>(
      create: (context) => CasesCampaignsBloc(
          caseCampaignRepository: FirebaseCaseCampaignRepository()),
      child: BlocConsumer<CasesCampaignsBloc, CasesCampaignsState>(
        listener: (context, state) {
          if (state is EditCampaignSuccess) {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) {
                  return SuccessDialog(onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                });
          }else if(state is EditCampaignFailure){
            showDialog(
                context: context,
                builder: (context) {
                  return FailureDialog(onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                });
          }else if(state is EditCampaignProcess){
            showDialog(
                context: context,
                builder: (context) {
                  return const LoadingDialog();
                });
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Back(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                            SecondDefaultText(text: getLang(context, "edit")!),
                      ),
                      Center(child: ShowImage(url: campaignModel.photo)),
                      const SizedBox(
                        height: 10.0,
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
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DefaultMaterialButton(
                        text: getLang(context, "edit")!,
                        textColor: Colors.white,
                        buttonColor: MyColors.myBlue,
                        function: () {
                          if (formKey.currentState!.validate()) {
                            CampaignModel campaignModelTemp =
                                campaignModel.edit(
                              title: titleController.text,
                              description: descriptionController.text,
                              allAmount: moneyController.text,
                              photo: campaignModel.photo,
                              collectedAmount: campaignModel.collectedAmount,
                            );
                            context.read<CasesCampaignsBloc>().add(
                                EditCampaignEvent(
                                    campaignModel: campaignModelTemp));
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
          );
        },
      ),
    );
  }
}
