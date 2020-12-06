import 'package:bei/pages/splashscreen_page.dart';
import 'package:bei/provider/language_provider.dart';
import 'package:bei/provider/user_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) => Scaffold(
        body: Container(
          color: backgroundColor,
          padding: EdgeInsets.only(
            top: paddingNormal,
          ),
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: appBarHeight,
                  color: backgroundColor,
                  child: Center(
                    child: CustomText(
                      text: languageProvider.language ? enSetting : inaSetting,
                      size: regular,
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: primaryColor,
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(
                        left: paddingSmall,
                        right: paddingSmall,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.language, size: regular),
                              SizedBox(
                                width: paddingSmall,
                              ),
                              CustomText(
                                text: languageProvider.language
                                    ? enLanguage
                                    : inaLanguage,
                                size: small,
                              ),
                            ],
                          ),
                          Switch(
                            value: languageProvider.language,
                            onChanged: (value) {
                              setState(() {
                                languageProvider.language = value;
                              });
                            },
                            activeTrackColor: Colors.greenAccent[700],
                            activeColor: secondaryColor,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.announcement_outlined, size: regular),
                            SizedBox(
                              width: paddingSmall,
                            ),
                            CustomText(
                              text: languageProvider.language ? enFAQ : inaFAQ,
                              size: small,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, size: regular),
                            SizedBox(
                              width: paddingSmall,
                            ),
                            CustomText(
                              text: languageProvider.language
                                  ? enAbout
                                  : inaAbout,
                              size: small,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.article_outlined, size: regular),
                            SizedBox(
                              width: paddingSmall,
                            ),
                            CustomText(
                              text: languageProvider.language
                                  ? enLicense
                                  : inaLicense,
                              size: small,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.exit_to_app_outlined, size: regular),
                            SizedBox(
                              width: paddingSmall,
                            ),
                            CustomText(
                              text: languageProvider.language
                                  ? enSignOut
                                  : inaSignOut,
                              size: small,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        showAlertSignOut();
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertSignOut() {
    showDialog(
      context: context,
      builder: (_) => Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) => AlertDialog(
          title: CustomText(
            text: languageProvider.language ? enSignOut : inaSignOut,
            size: regular,
            color: primaryColor,
          ),
          content: CustomText(
            text: languageProvider.language ? enNotifSignOut : inaNotifSignOut,
            maxLine: 2,
            size: normal,
          ),
          actions: [
            FlatButton(
              child: CustomText(
                text: languageProvider.language ? enNo : inaNo,
                size: normal,
                color: primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: CustomText(
                text: languageProvider.language ? enYes : inaYes,
                size: normal,
                color: primaryColor,
              ),
              onPressed: () {
                GoogleSignIn _googleSignIn = GoogleSignIn(
                  scopes: [
                    'email',
                  ],
                );
                _googleSignIn.disconnect().then((value) async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear().then(
                        (value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashScreenPage(),
                          ),
                        ),
                      );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
