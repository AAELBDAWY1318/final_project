
import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/widgets/animated_text.dart';
import 'package:flutter/material.dart';

class ThankYouView extends StatefulWidget {
  const ThankYouView({super.key});

  @override
  State<ThankYouView> createState() => _ThankYouViewState();
}

class _ThankYouViewState extends State<ThankYouView> {
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/thanks.png',
              height: 130.0,
              width: 130.0,
            ),
            const SizedBox(height: 15.0,),
            Center(
              child: AnimatedTextWriter(
                text:getLang(context, "thanks")!,
                onTextWritingDone: (bool val){
                  flag = val;
                  setState((){});
                },
              ),
            ),
            const SizedBox(height: 20.0,),
            Visibility(
              visible: flag,
              child: Column(
                children: [
                  const CircularProgressIndicator(
                    color: Colors.green,
                  ),
                  const SizedBox(height: 15.0,),
                  Text(
                    getLang(context, "make report")!,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
