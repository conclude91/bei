import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/secondary_text.dart';
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
        height: AppDimen.buttonHeight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimen.buttonRadius),
        ),
        color: AppColor.primaryColor,
        icon: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimen.iconRadius),
          child: Container(
            color: AppColor.secondaryTextColor,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                widget.icon,
                width: AppDimen.medium,
                height: AppDimen.medium,
              ),
            ),
          ),
        ),
        label: SecondaryText(
          text: widget.text,
          size: AppDimen.small,
        ),
        onPressed: widget.onPressed,
      );
    } else {
      return FlatButton(
        height: AppDimen.buttonHeight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimen.buttonRadius),
        ),
        color: AppColor.primaryColor,
        child: SecondaryText(
          text: widget.text,
          size: AppDimen.small,
        ),
        onPressed: widget.onPressed,
      );
    }
  }
}
