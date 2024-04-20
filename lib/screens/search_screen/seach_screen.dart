import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    AppLocale.of(context).loadLang();
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
                  validator: (String? val){
                    if(val!.length < 14){
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
                  function: (){
                    if(formKey.currentState!.validate()){

                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
