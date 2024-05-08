import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/cases_campaigns_bloc/cases_campaigns_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/add_campaign_screen/add_campaign_screen.dart';
import 'package:charity/screens/edit_campaign_screen/edit_campaign_screen.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/details_component.dart';
import 'package:charity/widgets/failure_dialog.dart';
import 'package:charity/widgets/loading_dialog.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:charity/widgets/show_image_component.dart';
import 'package:charity/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CampaignAdminView extends StatelessWidget {
  final CampaignModel campaignModel;

  const CampaignAdminView({super.key, required this.campaignModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CasesCampaignsBloc>(
      create: (context) => CasesCampaignsBloc(
          caseCampaignRepository: FirebaseCaseCampaignRepository()),
      child: BlocConsumer<CasesCampaignsBloc, CasesCampaignsState>(
        listener: (context, state) {
          if (state is RemoveCampaignSuccess) {
            showDialog(
                context: context,
                builder: (context) {
                  return SuccessDialog(onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                });
          } else if (state is RemoveCampaignFailure) {
            showDialog(
                context: context,
                builder: (context) {
                  return FailureDialog(onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                });
          } else if (state is RemoveCampaignProcess) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Back(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                          SecondDefaultText(text: getLang(context, 'details')!),
                    ),
                    Center(child: ShowImage(url: campaignModel.photo)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DetailsCom(
                        what: getLang(context, 'title')!,
                        res: campaignModel.title,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DetailsCom(
                        what: getLang(context, 'des')!,
                        res: '',
                      ),
                    ),
                    Center(
                      child: Text(
                        campaignModel.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: LinearProgressIndicator(
                        value: double.parse(campaignModel.collectedAmount) == 0
                            ? 0.0
                            : double.parse(campaignModel.collectedAmount) /
                                double.parse(campaignModel.allAmount),
                        color: MyColors.myBlue,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        campaignModel.collectedAmount,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.myBlue,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        campaignModel.allAmount,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultMaterialButton(
                            text: getLang(context, "remove")!,
                            textColor: Colors.white,
                            buttonColor: Colors.red,
                            function: () {
                              context.read<CasesCampaignsBloc>().add(
                                    RemoveCampaignEvent(
                                        campaignModel: campaignModel),
                                  );
                            },
                          ),
                        ),
                        Expanded(
                          child: DefaultMaterialButton(
                            text: getLang(context, "edit")!,
                            textColor: Colors.white,
                            buttonColor: Colors.green,
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditCampaignScreen(
                                          campaignModel: campaignModel)));
                            },
                          ),
                        ),
                      ],
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
