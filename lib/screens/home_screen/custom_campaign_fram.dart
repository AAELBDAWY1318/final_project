import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/cases_campaigns_bloc/cases_campaigns_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/campaign_donor_view/campaign_donor_view.dart';
import 'package:charity/size.dart';
import 'package:charity/widgets/animated_loading.dart';
import 'package:charity/widgets/case_component.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCampaignFrame extends StatelessWidget {
  const CustomCampaignFrame({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return BlocProvider<CasesCampaignsBloc>(
      create: (context) => CasesCampaignsBloc(
          caseCampaignRepository: FirebaseCaseCampaignRepository())
        ..add(
          GetCampaignsEvent(),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SecondDefaultText(
            text: getLang(context, "campaigns")!,
            fontColor: Colors.black,
          ),
          const SizedBox(
            height: 10.0,
          ),
          BlocBuilder<CasesCampaignsBloc, CasesCampaignsState>(
            builder: (context, state) {
              if (state is GetCampaignsFailure) {
                return Center(
                  child: Image.asset(
                    'assets/images/failure.png',
                    height: 100,
                    width: 100,
                  ),
                );
              } else if (state is GetCampaignsSuccess) {
                if (state.list.isNotEmpty) {
                  return SizedBox(
                    height: sizeConfig.screenHeight! * 0.4,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CaseComponent(
                            imageUrl: state.list[index].photo,
                            title: state.list[index].title,
                            description: state.list[index].description,
                            collectedAmount: double.parse(
                                state.list[index].collectedAmount),
                            allAmount: double.parse(
                                state.list[index].allAmount),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CampaignDonorView(
                                            campaignModel:
                                            state.list[index])),
                              );
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
              } else {
                return Center(
                    child: Container(
                      color: MyColors.myWhile,
                      child: const LoadingAnimation(),
                    ));
              }
            },
          ),
        ],
      ),
    );
  }
}
