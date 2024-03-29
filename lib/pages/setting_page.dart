import 'dart:io';

import 'package:bei/pages/about_page.dart';
import 'package:bei/pages/faq_page.dart';
import 'package:bei/pages/licenses_page.dart';
import 'package:bei/provider/language_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isProcessingSignOut = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) => Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
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
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(
                    top: 0,
                  ),
                  shrinkWrap: true,
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
                          DropdownButton<String>(
                            items: <String>['English', 'Indonesian']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: CustomText(
                                  text: value,
                                  size: small,
                                ),
                              );
                            }).toList(),
                            underline: SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                value == 'English'
                                    ? languageProvider.language = true
                                    : languageProvider.language = false;
                              });
                            },
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FAQPage(),
                          ),
                        );
                      },
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutPage(),
                          ),
                        );
                      },
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LicensesPage(),
                          ),
                        );
                      },
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showAlertSignOut() {
    (Platform.isIOS)
        ? showDialog(
            context: context,
            builder: (_) => Consumer<LanguageProvider>(
              builder: (context, languageProvider, _) => CupertinoAlertDialog(
                title: Text(
                  languageProvider.language ? enSignOut : inaSignOut,
                  style: TextStyle(
                    fontSize: regular,
                    color: primaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: CustomText(
                  text: languageProvider.language
                      ? enNotifSignOut
                      : inaNotifSignOut,
                  maxLine: 2,
                  size: normal,
                ),
                actions: [
                  CupertinoDialogAction(
                    child: Text(
                      languageProvider.language ? enNo : inaNo,
                      style: TextStyle(
                        fontSize: normal,
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      if (_isProcessingSignOut == false) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      languageProvider.language ? enYes : inaYes,
                      style: TextStyle(
                        fontSize: normal,
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () async {
                      if (_isProcessingSignOut == false) {
                        setState(() {
                          _isProcessingSignOut = true;
                        });
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        if (Platform.isAndroid) {
                          GoogleSignIn _googleSignIn = GoogleSignIn(
                            scopes: [
                              'email',
                            ],
                          );
                          await _googleSignIn.disconnect().then((value) {
                            preferences.clear();
                            Phoenix.rebirth(context);
                          });
                        } else if (Platform.isIOS) {
                          preferences.clear();
                          Phoenix.rebirth(context);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        : showDialog(
            context: context,
            builder: (_) => Consumer<LanguageProvider>(
              builder: (context, languageProvider, _) => AlertDialog(
                title: CustomText(
                  text: languageProvider.language ? enSignOut : inaSignOut,
                  size: regular,
                  color: primaryColor,
                ),
                content: CustomText(
                  text: languageProvider.language
                      ? enNotifSignOut
                      : inaNotifSignOut,
                  maxLine: 2,
                  size: normal,
                ),
                actions: [
                  TextButton(
                    child: CustomText(
                      text: languageProvider.language ? enNo : inaNo,
                      size: normal,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      if (_isProcessingSignOut == false) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  TextButton(
                    child: CustomText(
                      text: languageProvider.language ? enYes : inaYes,
                      size: normal,
                      color: primaryColor,
                    ),
                    onPressed: () async {
                      if (_isProcessingSignOut == false) {
                        setState(() {
                          _isProcessingSignOut = true;
                        });
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        if (Platform.isAndroid) {
                          GoogleSignIn _googleSignIn = GoogleSignIn(
                            scopes: [
                              'email',
                            ],
                          );
                          await _googleSignIn.disconnect().then((value) {
                            preferences.clear();
                            Phoenix.rebirth(context);
                          });
                        } else if (Platform.isIOS) {
                          preferences.clear();
                          Phoenix.rebirth(context);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
