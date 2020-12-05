import 'dart:async';

import 'package:bei/pages/dashboard_page.dart';
import 'package:bei/pages/onboarding_page.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    nextPage();
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
              alignment: Alignment.center,
              child: SizedBox(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fitHeight,
                  height: 150,
                  width: 150,
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
                  size: normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  nextPage() {
    return timer = Timer(Duration(seconds: 3), () async {
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
