import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                text: AppString.welcomeHi,
                size: AppDimen.normal,
              ),
              PrimaryText(
                text: AppString.welcomeBack,
                size: AppDimen.normal,
              ),
              PrimaryText(
                text: AppString.appName,
                size: AppDimen.medium,
              ),
            ],
          ),
          CircleAvatar(
            radius: AppDimen.avatarMedium,
            backgroundImage: AssetImage(
              'assets/images/profile.jpg',
            ),
          ),
        ],
      ),
    );
  }
}
