import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/cases_campaigns_bloc/cases_campaigns_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/case_admin_viewScreen/case_admin_view.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/case_ticket.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    AppLocale.of(context).loadLang();
    Widget building = const Text('');
    return BlocProvider<CasesCampaignsBloc>(
      create: (context) => CasesCampaignsBloc(
          caseCampaignRepository: FirebaseCaseCampaignRepository()),
      child: BlocConsumer<CasesCampaignsBloc, CasesCampaignsState>(
        listener: (context, state) {
          if (state is SearchInCasesProcess) {
            building = processBuilding();
          } else if (state is SearchInCasesFailure) {
            building = failureBuilding();
          } else if (state is SearchInCasesSuccess) {
            building = successBuilding(state.caseModel, context);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Back(),
                      DefaultTextFormField(
                        icon: Icons.search,
                        label: getLang(context, 'search')!,
                        controller: searchController,
                        validator: (String? val) {
                          if (val!.length < 14) {
                            return getLang(context, 'id length')!;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      DefaultMaterialButton(
                        text: getLang(context, "Continue")!,
                        textColor: Colors.white,
                        buttonColor: MyColors.myBlue,
                        function: () {
                          if (formKey.currentState!.validate()) {
                            context.read<CasesCampaignsBloc>().add(
                                  SearchInCasesEvent(
                                      caseId: searchController.text),
                                );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      building,
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

  Widget processBuilding() {
    return CircularProgressIndicator(
      color: MyColors.myBlue,
    );
  }

  Widget successBuilding(CaseModel caseModel, BuildContext context) {
    if (caseModel.caseId.isNotEmpty) {
      return CaseTicket(
        name: caseModel.name,
        id: caseModel.caseId,
        description: caseModel.description,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CaseAdminViewScreen(
                        caseInfo: caseModel,
                      )));
        },
      );
    } else {
      return Text(
        getLang(context, "no case")!,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 20.0,
        ),
      );
    }
  }

  Widget failureBuilding() {
    return Center(child: Image.asset('assets/images/failure.png'));
  }
}
