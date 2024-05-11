import 'dart:developer';
import 'package:charity/layout/app_layout.dart';
import 'package:charity/screens/donate_screen/thank_you_view.dart';
import 'package:donation_repository/donation_repository.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'dart:async';

class PayMobIFrame extends StatefulWidget {
  final String visaUrl;
  final DonationModel donationModel;
  const PayMobIFrame({super.key, required this.visaUrl, required this.donationModel});

  @override
  State<PayMobIFrame> createState() => _PayMobIFrameState();
}

class _PayMobIFrameState extends State<PayMobIFrame> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(actions: [
          IconButton(
            onPressed: () {
              paymentExitApp(context);
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          )
        ],
          leading: const SizedBox(),
          backgroundColor: Colors.white,
        ),
        body: WebView(
          initialUrl: widget.visaUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            log('WebView is loading (progress : $progress%)');
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              log('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            log('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            log('Page started loading: $url');
            log(widget.visaUrl);
          },
          onPageFinished: (String url) {
            log('Page finished loading: $url');
            if (url.contains('data.message=Approved')){
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context){
                    return  ThankYouView(
                      donationModel: widget.donationModel,
                    );
                  }), (route) => false);
            }
          },
          gestureNavigationEnabled: true,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }

  // to exit from app
  void paymentExitApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Are you sure completed the pay',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const AppLayout()),
                    (route) => false);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
