import 'dart:io';

import 'package:bei/consts/constanta.dart';
import 'package:bei/pages/dashboard_page.dart';
import 'package:bei/provider/language_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/custom_button.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.white,
                BlendMode.colorBurn,
              ),
              image: AssetImage('assets/images/background-potrait.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          padding: EdgeInsets.only(
            top: Platform.isIOS ? paddingMedium : paddingNormal,
            bottom: paddingNormal,
            left: paddingNormal,
            right: paddingNormal,
          ),
          width: double.infinity,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: languageProvider.language
                          ? enWelcomeHi
                          : inaWelcomeHi,
                      size: medium,
                    ),
                    SizedBox(
                      height: paddingSmall,
                    ),
                    CustomText(
                      text: languageProvider.language
                          ? enWelcomeMessage
                          : inaWelcomeMessage,
                      size: large,
                    ),
                  ],
                ),
                (Platform.isIOS)
                    ? CustomButton(
                        icon: 'assets/images/apple.png',
                        text: languageProvider.language
                            ? enConnectWithApple
                            : inaConnectWithApple,
                        onPressed: () {
                          if (_loading == false) {
                            signInApple();
                          }
                        },
                      )
                    : CustomButton(
                        icon: 'assets/images/google.webp',
                        text: languageProvider.language
                            ? enConnectWithGoogle
                            : inaConnectWithGoogle,
                        onPressed: () {
                          if (_loading == false) {
                            signInGoogle();
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signInApple() async {
    String email = '';
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      if (appleCredential.email != null) {
        email = appleCredential.email;
      } else {
        email = appleCredential.givenName.toLowerCase() +
            '.' +
            appleCredential.familyName.toLowerCase() +
            '@bukunesia.id';
      }
      prefs.setString('email', email);
      prefs.setBool('isLogin', true);
      signInUser(email.toLowerCase());
    } catch (exception) {
      print(exception);
    }
  }

  signInGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      await _googleSignIn.signIn().then((GoogleSignInAccount acc) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', acc.email);
        prefs.setBool('isLogin', true);
        signInUser(acc.email);
      });
    } catch (error) {
      print(error);
    }
  }

  signInUser(String email) async {
    setState(() {
      _loading = true;
    });

    var request =
        http.MultipartRequest('POST', Uri.parse(Constanta.SIGNIN_USER));
    request.fields.addAll({
      'email': email,
    });

    try {
      await request.send().then((response) {
        if (response.statusCode == 200) {
          setState(() {
            _loading = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardPage(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: Provider.of<LanguageProvider>(context, listen: false).language
                ? enFailedSignIn
                : inaFailedSignIn,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
          );
        }
      });
    } catch (exception) {
      print(exception);
    }
  }
}
