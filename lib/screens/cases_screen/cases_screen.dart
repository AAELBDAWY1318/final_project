import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/cases_campaigns_bloc/cases_campaigns_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/add_new_case_screen/add_new_case_screen.dart';
import 'package:charity/screens/case_admin_viewScreen/case_admin_view.dart';
import 'package:charity/screens/search_screen/seach_screen.dart';
import 'package:charity/widgets/animated_loading.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/case_ticket.dart';
import 'package:charity/widgets/search_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_repository/request_repository.dart';

class CasesScreen extends StatelessWidget {
  const CasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    return BlocProvider(
      create: (context) => CasesCampaignsBloc(
          caseCampaignRepository: FirebaseCaseCampaignRepository())
        ..add(GetAllCasesEvent()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddNewCaseScreen(request: Request.empty)),
              );
            },
            backgroundColor: MyColors.myBlue,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Back(),
                SearchBox(
                  text: getLang(context, 'search')!,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()));
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                BlocBuilder<CasesCampaignsBloc , CasesCampaignsState>(builder: (context , state){
                  if(State is GetAllCasesFailure){
                    return getCasesFailureBuilding();
                  }else if(state is GetAllCasesSuccess){
                    return getCasesSuccessBuilding(state.list , context);
                  }else{
                    return loadingBuild();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // the body building when get cases is loading
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
