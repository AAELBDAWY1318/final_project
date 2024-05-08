import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/paymob_iframe/paymob_iframe.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/default_text_form_field.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/upper_com.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController amountController = TextEditingController();
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const UpperComponent(),
            SecondDefaultText(text: getLang(context, "Donate")!),
            const SizedBox(
              height: 15.0,
            ),
            DefaultTextFormField(
              icon: Icons.money_off,
              label: getLang(context, "amount")!,
              controller: amountController,
              validator: (String ? val){
                if(val!.isEmpty){
                  return getLang(context,  "This field must be assigned")!;
                }else if(!(double.tryParse(val) != null || int.tryParse(val) != null)){
                  return getLang(context, "invalid");
                }
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 15.0,
            ),
            DefaultMaterialButton(
              buttonColor: MyColors.myBlue,
              textColor: Colors.white,
              text: getLang(context, "Continue")!,
              function: (){
                if(formKey.currentState!.validate()){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> const PayMobIFrame())
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
