import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayMobIFrame extends StatefulWidget {
  const PayMobIFrame({super.key});

  @override
  State<PayMobIFrame> createState() => _PayMobIFrameState();
}

class _PayMobIFrameState extends State<PayMobIFrame> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://flutter.dev'),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
