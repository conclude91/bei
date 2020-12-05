import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/custom_button.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.white,
              BlendMode.colorBurn,
            ),
            image: AssetImage('assets/images/background-vector.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        padding: EdgeInsets.only(
          top: paddingMedium,
          bottom: paddingNormal,
          left: paddingNormal,
          right: paddingNormal,
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: welcomeHi,
                  size: medium,
                ),
                SizedBox(
                  height: paddingSmall,
                ),
                CustomText(
                  text: welcomeMessage,
                  size: large,
                ),
              ],
            ),
            CustomButton(
              icon: 'assets/images/google.webp',
              text: connectWithGoogle,
              onPressed: () {
                signIn();
              },
            ),
          ],
        ),
      ),
    );
  }

  void signIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/cloud-platform	',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    _googleSignIn.signIn().then((GoogleSignInAccount acc) async {
      GoogleSignInAuthentication auth = await acc.authentication;
      print(acc.id);
      print(acc.email);
      print(acc.displayName);
      print(acc.photoUrl);

      acc.authentication.then((GoogleSignInAuthentication auth) async {
        print(auth.idToken);
        print(auth.accessToken);
      });
    });
  }
}
