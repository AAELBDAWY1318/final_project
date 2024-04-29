import 'package:charity/widgets/payment_details.dart';
import 'package:flutter/material.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: const Text('Donate' , textAlign: TextAlign.center,),
       ),
         body: const PaymentDetails(),
    );
  }
}
