import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/cases_campaigns_bloc/cases_campaigns_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/details_component.dart';
import 'package:charity/widgets/show_image_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaseAdminViewScreen extends StatelessWidget {
  final CaseModel caseInfo;

  const CaseAdminViewScreen({super.key, required this.caseInfo});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    return BlocProvider<CasesCampaignsBloc>(
      create: (context) => CasesCampaignsBloc(
          caseCampaignRepository: FirebaseCaseCampaignRepository()),
      child: BlocConsumer<CasesCampaignsBloc, CasesCampaignsState>(
        listener: (context, state) {
          if(state is DeleteCaseProcess){
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
          }else if(state is DeleteCaseFailure){
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Image.asset('assets/images/failure.png'),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(getLang(context, "OK")!),
                      ),
                    ],
                  );
                }
            );
          }else if(state is DeleteCaseSuccess){
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Image.asset('assets/images/success.png'),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context); // pop dialog
                          Navigator.pop(context); // pop details screen
                          Navigator.pop(context);
                        },
                        child: Text(getLang(context, "OK")!),
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
                  child: Column(
                    children: [
                      const Back(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ShowImage(
                            url: caseInfo.idImage1,
                          ),
                          ShowImage(
                            url: caseInfo.idImage2,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      DetailsCom(
                        what: getLang(context, "Name")!,
                        res: caseInfo.name,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DetailsCom(
                        what: getLang(context, "national id")!,
                        res: caseInfo.caseId,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DetailsCom(
                        what: getLang(context, "Phone")!,
                        res: caseInfo.phone,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DetailsCom(
                        what: getLang(context, "des")!,
                        res: '',
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          caseInfo.description,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DefaultMaterialButton(
                        text: getLang(context, "remove")!,
                        textColor: Colors.white,
                        buttonColor: Colors.red,
                        function: () {
                          context.read<CasesCampaignsBloc>().add(
                            RemoveCaseEvent(caseId: caseInfo.caseId),
                          );
                        },
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
