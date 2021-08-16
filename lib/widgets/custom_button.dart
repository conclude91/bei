import 'dart:io';

import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final GestureTapCallback onPressed;
  final String icon;

  CustomButton({@required this.text, @required this.onPressed, this.icon});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return showButton();
  }

  Widget showButton() {
    return TextButton.icon(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
        backgroundColor: Platform.isIOS ? Colors.black : Colors.blue,
      ),
      icon: Padding(
        padding: EdgeInsets.all(8),
        child: Image.asset(
          widget.icon,
          width: regular,
          height: regular,
          color: Colors.white,
        ),
      ),
      label: CustomText(
        text: widget.text,
        size: 16,
        color: secondaryTextColor,
      ),
      onPressed: widget.onPressed,
    );
  }
}
