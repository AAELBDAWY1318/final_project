import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/cases_campaigns_bloc/cases_campaigns_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/add_campaign_screen/add_campaign_screen.dart';
import 'package:charity/screens/campaign_admin_view/campaign_admin_view.dart';
import 'package:charity/widgets/animated_loading.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/case_ticket.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageCampaign extends StatelessWidget {
  const ManageCampaign({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CasesCampaignsBloc>(
      create: (context) => CasesCampaignsBloc(
          caseCampaignRepository: FirebaseCaseCampaignRepository())
        ..add(
          GetCampaignsEvent(),
        ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const AddCampaignScreen()),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Back(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                      SecondDefaultText(text: getLang(context, "campaigns")!),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: BlocBuilder<CasesCampaignsBloc, CasesCampaignsState>(
                      builder: (context, state) {
                    if (state is GetCampaignsFailure) {
                      return Center(
                        child: Image.asset(
                          'assets/images/failure.png',
                          height: 120.0,
                        ),
                      );
                    } else if (state is GetCampaignsSuccess) {
                      if (state.list.isNotEmpty) {
                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CaseTicket(
                                  name: state.list[index].title,
                                  id: state.list[index].allAmount,
                                  description: state.list[index].description,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CampaignAdminView(
                                                  campaignModel:
                                                      state.list[index])),
                                    );
                                  });
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10.0,
                              );
                            },
                            itemCount: state.list.length);
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
                      return const Center(child: LoadingAnimation());
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
