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
          caseCampaignRepository: FirebaseCaseCampaignRepository()),
      child: BlocConsumer<CasesCampaignsBloc, CasesCampaignsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Padding(
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
                  SizedBox(
                    height: sizeConfig.screenHeight! * 0.35,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 5.0,
                      ),
                      itemCount: comp.length,
                      itemBuilder: (context, index) => CaseComponent(
                        image: comp[index]['image'],
                        description: comp[index]['description'],
                        title: comp[index]['title'],
                        get: comp[index]['get'],
                        all: comp[index]['all'],
                        indicatorValue: comp[index]['get'] / comp[index]['all'],
                        onTap: () {},
                        onPress: () {},
                        text: getLang(context, 'donate')!,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SecondDefaultText(text: getLang(context, 'Cases')!),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CategoryComponent(
                          text: getLang(context, "All")!,
                          color: CasesCampaignsBloc.get(context).index == 0
                              ? MyColors.myBlue
                              : MyColors.myWhile,
                          textColor: CasesCampaignsBloc.get(context).index == 0
                              ? Colors.white
                              : Colors.black,
                          function: () {
                            CasesCampaignsBloc.get(context)
                                .add(const ChangeCategory(index: 0));
                          },
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        CategoryComponent(
                          text: getLang(context, "Poor")!,
                          color: CasesCampaignsBloc.get(context).index == 1
                              ? MyColors.myBlue
                              : MyColors.myWhile,
                          textColor: CasesCampaignsBloc.get(context).index == 1
                              ? Colors.white
                              : Colors.black,
                          function: () {
                            CasesCampaignsBloc.get(context)
                                .add(const ChangeCategory(index: 1));
                          },
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        CategoryComponent(
                          text: getLang(context, "Widows")!,
                          color: CasesCampaignsBloc.get(context).index == 2
                              ? MyColors.myBlue
                              : MyColors.myWhile,
                          textColor: CasesCampaignsBloc.get(context).index == 2
                              ? Colors.white
                              : Colors.black,
                          function: () {
                            CasesCampaignsBloc.get(context)
                                .add(const ChangeCategory(index: 2));
                          },
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        CategoryComponent(
                          text: getLang(context, "Students")!,
                          color: CasesCampaignsBloc.get(context).index == 3
                              ? MyColors.myBlue
                              : MyColors.myWhile,
                          textColor: CasesCampaignsBloc.get(context).index == 3
                              ? Colors.white
                              : Colors.black,
                          function: () {
                            CasesCampaignsBloc.get(context)
                                .add(const ChangeCategory(index: 3));
                          },
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        CategoryComponent(
                          text: getLang(context, "Debtors")!,
                          color: CasesCampaignsBloc.get(context).index == 4
                              ? MyColors.myBlue
                              : MyColors.myWhile,
                          textColor: CasesCampaignsBloc.get(context).index == 4
                              ? Colors.white
                              : Colors.black,
                          function: () {
                            CasesCampaignsBloc.get(context)
                                .add(const ChangeCategory(index: 4));
                          },
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: sizeConfig.screenHeight! * 0.35,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 5.0,
                      ),
                      itemCount: comp.length,
                      itemBuilder: (context, index) => CaseComponent(
                        image: comp[index]['image'],
                        description: comp[index]['description'],
                        title: comp[index]['title'],
                        get: comp[index]['get'],
                        all: comp[index]['all'],
                        indicatorValue: comp[index]['get'] / comp[index]['all'],
                        onTap: () {},
                        onPress: () {},
                        text: getLang(context, 'donate')!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
