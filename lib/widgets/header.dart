import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/custom_text.dart';
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
              CustomText(
                text: welcomeHi,
                size: normal,
              ),
              CustomText(
                text: welcomeBack,
                size: normal,
              ),
              CustomText(
                text: appName,
                size: medium,
              ),
            ],
          ),
          CircleAvatar(
            radius: avatarMedium,
            backgroundImage: AssetImage(
              'assets/images/profile.jpg',
            ),
          ),
        ],
      ),
    );
  }
}
