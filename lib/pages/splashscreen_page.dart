import 'dart:async';

import 'package:bei/pages/dashboard_page.dart';
import 'package:bei/pages/onboarding_page.dart';
import 'package:bei/provider/language_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Timer timer;

  @override
  void initState() {
    nextPage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LanguageProvider>(context, listen: false).fetchAll();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: paddingSmall,
          right: paddingSmall,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: paddingLarge,
                ),
                child: CustomText(
                  text: 'Selamat Datang Di Bukunesia',
                  color: primaryTextColor,
                  size: medium,
                  align: TextAlign.center,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fitHeight,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: paddingLarge,
                ),
                child: CustomText(
                  text: 'Pusat Kurikulum Dan Perbukuan\nKemendikbud',
                  color: primaryTextColor,
                  size: medium,
                  align: TextAlign.center,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: paddingSmall,
                ),
                child: CustomText(
                  text: 'Copyright © 2020',
                  color: primaryTextColor,
                  size: small,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  nextPage() {
    return timer = Timer(Duration(seconds: 5), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('isLogin') ?? false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnboardingPage(),
          ),
        );
      }
    });
  }
}
