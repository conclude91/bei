import 'package:bei/provider/book_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, _) => Scaffold(
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
                      text: bookProvider.isSwitch ? 'Pengaturan' : 'Settings',
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
                                text: bookProvider.isSwitch
                                    ? 'Bahasa'
                                    : 'Language',
                                size: small,
                              ),
                            ],
                          ),
                          Switch(
                            value: bookProvider.isSwitch,
                            onChanged: (value) {
                              setState(() {
                                bookProvider.isSwitch = value;
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
                              text: 'FAQ',
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
                              text: bookProvider.isSwitch
                                  ? 'Tentang Aplikasi '
                                  : 'About',
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
                              text: 'Licenses',
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
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
