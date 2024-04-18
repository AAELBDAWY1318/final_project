import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/size.dart';
import 'package:charity/widgets/case_comp.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    AppLocale.of(context).loadLang();
    List<Map<String , dynamic>> comp = [
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          const SizedBox(
            height: 50.0,
          ),
          SecondDefaultText(text: getLang(context, "campaigns")!),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: sizeConfig.screenHeight! *0.35,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context , index) => const SizedBox(width: 5.0,),
              itemCount: comp.length,
              itemBuilder:(context , index) =>CaseComponent(
                image: comp[index]['image'],
                description: comp[index]['description'],
                title: comp[index]['title'],
                get: comp[index]['get'],
                all: comp[index]['all'],
                indicatorValue: comp[index]['get'] /comp[index]['all'],
                onTap: (){},
                onPress: (){},
                text: getLang(context, 'donate')!,
              ) ,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),

        ],
      ),
    );
  }
}
