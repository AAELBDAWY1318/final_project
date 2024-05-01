import 'dart:developer';

import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/donate_screen/thank_you_view.dart';
import 'package:charity/widgets/custom_credit_card.dart';
import 'package:charity/widgets/payment_method_item.dart';
import 'package:charity/widgets/payment_methods_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'default_material_button.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: PaymentMethodListView(),
        ),
        SliverToBoxAdapter(
          child: custom_credit_card(
            autovalidateMode: autovalidateMode,
            formKey: formKey,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 18, right: 18),
              child: DefaultMaterialButton(
                textColor: MyColors.myWhile,
                buttonColor: MyColors.myBlue,
                function: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    log('Donate');
                  } else {
                    // هنا بعمل navigate بس من غير حاجه
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const ThankYouView();
                    }));
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                text: 'Donate',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
