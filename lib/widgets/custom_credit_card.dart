import 'package:charity/widgets/default_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../constant/my_colors.dart';

class custom_credit_card extends StatefulWidget {
  const custom_credit_card(
      {super.key, required this.formKey, required this.autovalidateMode});

  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;

  @override
  State<custom_credit_card> createState() => _custom_credit_cardState();
}

class _custom_credit_cardState extends State<custom_credit_card> {
  String cardNumber = '', expiryDate = '', cardHolderName = '', cvvCode = '';

  bool showBackView = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: showBackView,
            isHolderNameVisible: true,
            onCreditCardWidgetChange: (value) {}),
        CreditCardForm(
            autovalidateMode: widget.autovalidateMode,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            onCreditCardModelChange: (carditCardModel) {
              cardHolderName = carditCardModel.cardHolderName;
              expiryDate = carditCardModel.expiryDate;
              cvvCode = carditCardModel.cvvCode;
              cardNumber = carditCardModel.cardNumber;
              showBackView = carditCardModel.isCvvFocused;
              setState(() {});
            },
            formKey: widget.formKey),
      ],
    );
  }
}
