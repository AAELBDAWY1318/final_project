import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/cases_campaigns_bloc/cases_campaigns_bloc.dart';
import 'package:charity/screens/case_donor_view/case_donor_view.dart';
import 'package:charity/size.dart';
import 'package:charity/widgets/case_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/animated_loading.dart';

class WidowsCasesFrame extends StatelessWidget {
  const WidowsCasesFrame({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return BlocProvider<CasesCampaignsBloc>(
      create: (context) => CasesCampaignsBloc(
          caseCampaignRepository: FirebaseCaseCampaignRepository())
        ..add(
          GetWidowsCasesEvent(),
        ),
      child: BlocBuilder<CasesCampaignsBloc , CasesCampaignsState>(
        builder: (context , state){
          if(state is GetWidowsCasesFailure){
            return Center(
              child: Image.asset(
                'assets/images/failure.png',
                height: 100,
                width: 100,
              ),
            );
          }else if (state is GetWidowsCasesSuccess){
            if (state.list.isNotEmpty) {
              return SizedBox(
                height: sizeConfig.screenHeight! * 0.4,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CaseComponent(
                          title: "XXX XXX",
                          description: state.list[index].description,
                          collectedAmount: double.parse(
                              state.list[index].getAmount),
                          allAmount: double.parse(
                              state.list[index].allAmount),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CaseDonorView(
                                      caseModel: state.list[index])));
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                    const SizedBox(
                      width: 5.0,
                    ),
                    itemCount: state.list.length),
              );
            } else {
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
            }
          }else {
            return const Center(
                child: LoadingAnimation());
          }
        },
      ),
    );
  }
}
