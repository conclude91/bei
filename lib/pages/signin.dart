import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/primary_button.dart';
import 'package:bei/widgets/primary_large_text.dart';
import 'package:bei/widgets/primary_medium_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColor.secondaryColor,
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(
          top: AppDimen.paddingLong,
          bottom: AppDimen.paddingShort,
          left: AppDimen.paddingShort,
          right: AppDimen.paddingShort,
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryMediumText(AppString.welcomeHi),
                PrimaryLargeText(AppString.welcomeMessage),
              ],
            ),
            PrimaryButton(
              icon: 'assets/images/google.webp',
              text: AppString.connectWithGoogle,
              onPressed: () {
                showAction();
              },
            ),
          ],
        ),
      ),
    );
  }

  showAction() {
    print('Clicked');
  }
}
