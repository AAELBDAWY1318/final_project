import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/campaign_case_upper_component.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:flutter/material.dart';

class CampaignDonorView extends StatelessWidget {
  final CampaignModel campaignModel;
  const CampaignDonorView({super.key, required this.campaignModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CampaignOrCaseUpperComponent(
              imageUrl: campaignModel.photo,
            ),
            const SizedBox(
              height: 10.0,
            ),
            SecondDefaultText(text: campaignModel.title),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
            Text(
              campaignModel.collectedAmount,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.myBlue,
                fontSize: 17.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              campaignModel.allAmount,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 17.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            DefaultMaterialButton(
              text: getLang(context, "donate")!,
              buttonColor: MyColors.myBlue,
              textColor: Colors.white,
              function: (){},
            ),
          ],
        ),
      ),
    );
  }
}
