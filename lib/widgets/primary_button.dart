import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final GestureTapCallback onPressed;
  final String icon;

  PrimaryButton({@required this.text, @required this.onPressed, this.icon});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return showButton();
  }

  Widget showButton() {
    if (widget.icon != null) {
      return FlatButton.icon(
        height: buttonHeight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        color: primaryColor,
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
          size: small,
        ),
        onPressed: widget.onPressed,
      );
    } else {
      return FlatButton(
        height: buttonHeight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        color: primaryColor,
        child: CustomText(
          text: widget.text,
          size: small,
        ),
        onPressed: widget.onPressed,
      );
    }
  }
}
