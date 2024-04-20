import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/search_screen/seach_screen.dart';
import 'package:charity/size.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/case_ticket.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:charity/widgets/search_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CasesScreen extends StatelessWidget {
  const CasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: (){

          },
          backgroundColor: MyColors.myBlue,
          child: const Icon(Icons.add , color: Colors.white,),
        ),
        body: Column(
          children:
          [
            const Back(),
            SearchBox(
                text: getLang(context, 'search')!,
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> SearchScreen())
                  );
                },
            ),
            const SizedBox(height: 15.0,),
            CaseTicket(
              name: 'عبدالله عواد',
              description: "وصف وصف كتير و كلام هنكتبة انشاء الله",
              id: "1232454678",
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}
