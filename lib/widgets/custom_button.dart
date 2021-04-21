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
    if (widget.icon != null) {
      return TextButton.icon(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          backgroundColor: Platform.isIOS ? Colors.black : primaryColor,
        ),
        icon: ClipRRect(
          borderRadius: BorderRadius.circular(iconRadius),
          child: Container(
            color: secondaryTextColor,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                widget.icon,
                width: medium,
                height: medium,
              ),
            ),
          ),
        ),
        label: CustomText(
          text: widget.text,
          size: normal,
          color: secondaryTextColor,
        ),
        onPressed: widget.onPressed,
      );
    } else {
      return TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          backgroundColor: primaryColor,
        ),
        child: CustomText(
          text: widget.text,
          size: normal,
          color: secondaryTextColor,
        ),
        onPressed: widget.onPressed,
      );
    }
  }
}
