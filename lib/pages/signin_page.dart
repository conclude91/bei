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
              CustomButton(
                icon: 'assets/images/google.webp',
                text: languageProvider.language
                    ? enConnectWithGoogle
                    : inaConnectWithGoogle,
                onPressed: () {
                  signInGoogle();
                  // signInWithGoogle().whenComplete(() {
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (context) => DashboardPage(),
                  //     ),
                  //   );
                  // });
                },
              ),
            ],
          ),
        ),
      ),
    );
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

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response);
      Fluttertoast.showToast(
        msg: Provider.of<LanguageProvider>(context, listen: false).language
            ? enSuccessSignIn
            : inaSuccessSignIn,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
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
        msg: 'Login data failed',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
}
