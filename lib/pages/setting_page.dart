import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/primary_text.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    text: 'Settings',
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
                          Icon(Icons.bookmark_border),
                          SizedBox(
                            width: AppDimen.paddingNormal,
                          ),
                          PrimaryText(
                            text: 'Bookmark',
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
                          Icon(Icons.download_outlined),
                          SizedBox(
                            width: AppDimen.paddingNormal,
                          ),
                          PrimaryText(
                            text: 'Download',
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
                            text: 'About',
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
    );
  }
}
