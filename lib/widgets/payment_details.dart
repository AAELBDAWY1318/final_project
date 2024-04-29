import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/payment_method_item.dart';
import 'package:charity/widgets/payment_methods_list_view.dart';
import 'package:flutter/material.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [PaymentMethodListView()],
    );
  }
}
