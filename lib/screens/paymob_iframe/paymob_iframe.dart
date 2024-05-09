import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayMobIFrame extends StatefulWidget {
  final String paymentKey;
  const PayMobIFrame({super.key, required this.paymentKey});

  @override
  State<PayMobIFrame> createState() => _PayMobIFrameState();
}

class _PayMobIFrameState extends State<PayMobIFrame> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    log("IFrame:+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    log(widget.paymentKey);
    controller = WebViewController()
      ..loadRequest(
          Uri.parse("https://accept.paymob.com/api/acceptance/iframes/844976?payment_token=${widget.paymentKey}"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
