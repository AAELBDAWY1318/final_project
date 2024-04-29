import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/custom_credit_card.dart';
import 'package:charity/widgets/payment_method_item.dart';
import 'package:charity/widgets/payment_methods_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'default_material_button.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  //final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: PaymentMethodListView(),
        ),
        const SliverToBoxAdapter(
          child: custom_credit_card(),
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
                function: () {},
                text: 'Donate',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
