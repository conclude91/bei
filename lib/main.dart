import 'package:bei/pages/signin.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.appName,
      theme: ThemeData(
        primaryColor: AppColor.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignIn(),
    );
  }
}
