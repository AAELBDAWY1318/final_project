import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/cases_campaigns_bloc/cases_campaigns_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/size.dart';
import 'package:charity/widgets/case_comp.dart';
import 'package:charity/widgets/category_component.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    AppLocale.of(context).loadLang();
    List<Map<String, dynamic>> comp = [
      {
        'title': "عملية جراحيه",
        'description': "طفله تحتاج الي تدخل جراحي ع الفور ....",
        'image': 'assets/images/com.png',
        'all': 3000.0,
        'get': 1000.0,
      },
      {
        'title': "عملية جراحيه",
        'description': "طفله تحتاج الي تدخل جراحي ع الفور ....",
        'image': 'assets/images/com.png',
        'all': 3000.0,
        'get': 1000.0,
      },
      {
        'title': "عملية جراحيه",
        'description': "طفله تحتاج الي تدخل جراحي ع الفور ....",
        'image': 'assets/images/com.png',
        'all': 3000.0,
        'get': 1000.0,
      },
      {
        'title': "عملية جراحيه",
        'description': "طفله تحتاج الي تدخل جراحي ع الفور ....",
        'image': 'assets/images/com.png',
        'all': 3000.0,
        'get': 1000.0,
      },
    ];

    return BlocProvider<CasesCampaignsBloc>(
        create: (context) => CasesCampaignsBloc(
            caseCampaignRepository: FirebaseCaseCampaignRepository())..add(
          GetCampaignsEvent(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                SecondDefaultText(text: getLang(context, "campaigns")!),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ));
  }
}
