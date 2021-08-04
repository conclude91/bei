import 'package:bei/provider/language_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LicensesPage extends StatefulWidget {
  @override
  _LicensesPageState createState() => _LicensesPageState();
}

class _LicensesPageState extends State<LicensesPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) => Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: appBarHeight,
                color: backgroundColor,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: paddingTiny,
                          right: paddingTiny,
                        ),
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(paddingTiny),
                            child: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text:
                            languageProvider.language ? enLicense : inaLicense,
                        size: regular,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: primaryColor,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 0),
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: paddingSmall,
                        right: paddingSmall,
                        top: paddingTiny,
                        bottom: paddingTiny,
                      ),
                      child: CustomText(
                        text: inaLicenseContent,
                        size: normal,
                        align: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
