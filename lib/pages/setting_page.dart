import 'package:bei/provider/book_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/primary_text.dart';
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
          color: AppColor.backgroundColor,
          padding: EdgeInsets.only(
            top: AppDimen.paddingNormal,
          ),
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: AppDimen.appBarHeight,
                  color: AppColor.backgroundColor,
                  child: Center(
                    child: PrimaryText(
                      text: bookProvider.isSwitch ? 'Pengaturan' : 'Settings',
                      size: AppDimen.regular,
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: AppColor.primaryColor,
                ),
                Column(
                  children: [
                    InkWell(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          left: AppDimen.paddingSmall,
                          right: AppDimen.paddingSmall,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.account_circle),
                            SizedBox(
                              width: AppDimen.paddingNormal,
                            ),
                            PrimaryText(
                              text: bookProvider.isSwitch ? 'Akun' : 'Profile',
                              size: AppDimen.normal,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      height: 1,
                      color: AppColor.disableTextColor,
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(
                        left: AppDimen.paddingSmall,
                        right: AppDimen.paddingSmall,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.language),
                              SizedBox(
                                width: AppDimen.paddingNormal,
                              ),
                              PrimaryText(
                                text: bookProvider.isSwitch
                                    ? 'Bahasa'
                                    : 'Language',
                                size: AppDimen.normal,
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
                            activeTrackColor: AppColor.disableColor,
                            activeColor: AppColor.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: AppColor.disableTextColor,
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          left: AppDimen.paddingSmall,
                          right: AppDimen.paddingSmall,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.bookmark_outline),
                            SizedBox(
                              width: AppDimen.paddingNormal,
                            ),
                            PrimaryText(
                              text:
                                  bookProvider.isSwitch ? 'Tandai' : 'Bookmark',
                              size: AppDimen.normal,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      height: 1,
                      color: AppColor.disableTextColor,
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          left: AppDimen.paddingSmall,
                          right: AppDimen.paddingSmall,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.announcement_outlined),
                            SizedBox(
                              width: AppDimen.paddingNormal,
                            ),
                            PrimaryText(
                              text: 'FAQ',
                              size: AppDimen.normal,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      height: 1,
                      color: AppColor.disableTextColor,
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          left: AppDimen.paddingSmall,
                          right: AppDimen.paddingSmall,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline),
                            SizedBox(
                              width: AppDimen.paddingNormal,
                            ),
                            PrimaryText(
                              text: bookProvider.isSwitch
                                  ? 'Tentang Aplikasi '
                                  : 'About',
                              size: AppDimen.normal,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      height: 1,
                      color: AppColor.disableTextColor,
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          left: AppDimen.paddingSmall,
                          right: AppDimen.paddingSmall,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.article_outlined),
                            SizedBox(
                              width: AppDimen.paddingNormal,
                            ),
                            PrimaryText(
                              text: 'Licenses',
                              size: AppDimen.normal,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      height: 1,
                      color: AppColor.disableTextColor,
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
