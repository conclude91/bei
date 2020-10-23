import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondarySmallText extends StatefulWidget {
  final String text;

  SecondarySmallText(this.text);

  @override
  _SecondarySmallTextState createState() => _SecondarySmallTextState();
}

class _SecondarySmallTextState extends State<SecondarySmallText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      this.widget.text,
      style: GoogleFonts.poppins(
        color: AppColor.secondaryTextColor,
        fontSize: AppDimen.small,
        fontWeight: AppFont.light,
      ),
    );
  }
}
