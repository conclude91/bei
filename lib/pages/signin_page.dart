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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        languageProvider.language ? enWelcomeHi : inaWelcomeHi,
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
                        signInApple();
                      },
                    )
                  : CustomButton(
                      icon: 'assets/images/google.webp',
                      text: languageProvider.language
                          ? enConnectWithGoogle
                          : inaConnectWithGoogle,
                      onPressed: () {
                        signInGoogle();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  signInApple() async {
    await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      // webAuthenticationOptions: WebAuthenticationOptions(
      //   clientId: 'id.bukunesia.ios.signinapple',
      //   redirectUri: Uri.parse(
      //     'https://agate-funky-viola.glitch.me/callbacks/sign_in_with_apple',
      //   ),
      // ),
    ).then((credential) async {
      print(credential.email);
      print(credential.givenName);
      print(credential.familyName);
      // print(credential.state);
      // print(credential.identityToken);
      // print(credential.authorizationCode);
      if (credential.email != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', credential.email);
        await prefs.setBool('isLogin', true).then(
              (value) => signInUser(credential.email),
            );
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String email = credential.givenName.toString() +
            '.' +
            credential.familyName.toString() +
            '@bukunesia.id';
        await prefs.setString('email', email.toLowerCase());
        await prefs.setBool('isLogin', true).then(
              (value) => signInUser(email.toLowerCase()),
            );
      }
    });
    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
  }

  signInGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    _googleSignIn.signIn().then((GoogleSignInAccount acc) async {
      // GoogleSignInAuthentication auth = await acc.authentication;
      // print(acc.id);
      // print(acc.email);
      // print(acc.displayName);
      // print(acc.photoUrl);

      await acc.authentication.then((GoogleSignInAuthentication auth) async {
        print(auth.idToken);
        print(auth.accessToken);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', acc.email);
        await prefs.setBool('isLogin', true).then(
              (value) => signInUser(acc.email),
            );
      });
    });
  }

  signInUser(String email) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(Constanta.SIGNIN_USER));
    request.fields.addAll({
      'email': email,
    });

    await request.send().then((response) {
      if (response.statusCode == 200) {
        print(response);
        Fluttertoast.showToast(
          msg: Provider.of<LanguageProvider>(context, listen: false).language
              ? enSuccessSignIn
              : inaSuccessSignIn,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
        );
      } else {
        print(response.reasonPhrase);
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
  }
}
