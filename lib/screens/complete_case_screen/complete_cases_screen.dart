import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/blocs/cases_campaigns_bloc/cases_campaigns_bloc.dart';
import 'package:charity/screens/case_admin_viewScreen/case_admin_view.dart';
import 'package:charity/widgets/animated_loading.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/case_ticket.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_locale/app_locale.dart';

class CompleteCasesScreen extends StatelessWidget {
  const CompleteCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CasesCampaignsBloc>(
      create: (context) => CasesCampaignsBloc(
          caseCampaignRepository: FirebaseCaseCampaignRepository())
        ..add(
          GetCompletedCases(),
        ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Back(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SecondDefaultText(
                    text: getLang(context, "complete cases")!),
              ),
              BlocBuilder<CasesCampaignsBloc , CasesCampaignsState>(builder: (context , state){
                if(State is GetCompletedCasesFailure){
                  return getCasesFailureBuilding();
                }else if(state is GetCompletedCasesSuccess){
                  return getCasesSuccessBuilding(state.list , context);
                }else{
                  return loadingBuild();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
  Widget loadingBuild() {
    return const Center(
      child: LoadingAnimation(),
    );
  }

  Widget getCasesFailureBuilding() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Image.asset(
          'assets/images/failure.png',
          height: 120.0,
        ),
      ),
    );
  }

  Widget getCasesSuccessBuilding(List<CaseModel> list , BuildContext context) {
    if (list.isEmpty) {
      return Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/empty-box.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              getLang(context, "empty")!,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.separated(
          shrinkWrap: true,
          physics:const ScrollPhysics(),
          itemBuilder: (context, index) => CaseTicket(
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context)=> CaseAdminViewScreen(caseInfo: list[index])),
              );
            },
            description: list[index].description,
            id: list[index].caseId,
            name: list[index].name,
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 0.0,
          ),
          itemCount: list.length);
    }
  }
}
