import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/primary_button.dart';
import 'package:bei/widgets/primary_text.dart';
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
          top: AppDimen.paddingMedium,
          bottom: AppDimen.paddingNormal,
          left: AppDimen.paddingNormal,
          right: AppDimen.paddingNormal,
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  text: AppString.welcomeHi,
                  size: AppDimen.medium,
                ),
                PrimaryText(
                  text: AppString.welcomeMessage,
                  size: AppDimen.large,
                ),
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
