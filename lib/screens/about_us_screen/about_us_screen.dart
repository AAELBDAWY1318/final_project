import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:charity/widgets/upper_com.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const UpperComponent(),
            SecondDefaultText(
              text: getLang(context, 'about us')!,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                getLang(context, 'about')!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
