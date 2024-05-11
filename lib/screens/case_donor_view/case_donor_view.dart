import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/donate_screen/donate_screen.dart';
import 'package:charity/widgets/campaign_case_upper_component.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:flutter/material.dart';

import '../../app_locale/app_locale.dart';

class CaseDonorView extends StatelessWidget {
  final CaseModel caseModel;
  const CaseDonorView({super.key, required this.caseModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CampaignOrCaseUpperComponent(
              imagePath: 'assets/images/myLogo.png',
            ),
            const SizedBox(height: 20.0,),
            const SecondDefaultText(text:'XXXX XXXX'),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                caseModel.description,
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
                value: double.parse(caseModel.getAmount) == 0
                    ? 0.0
                    : double.parse(caseModel.getAmount) /
                    double.parse(caseModel.allAmount),
                color: MyColors.myBlue,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              caseModel.getAmount,
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
              caseModel.allAmount,
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
              function: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>Scaffold(
                    backgroundColor: Colors.white,
                    body: DonateScreen(
                      category: caseModel.category,
                      caseId: caseModel.caseId,
                    ),
                  )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
