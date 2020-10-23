import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryMediumText extends StatefulWidget {
  final String text;

  PrimaryMediumText(this.text);

  @override
  _PrimaryMediumTextState createState() => _PrimaryMediumTextState();
}

class _PrimaryMediumTextState extends State<PrimaryMediumText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      this.widget.text,
      style: GoogleFonts.poppins(
        color: AppColor.primaryTextColor,
        fontSize: AppDimen.medium,
        fontWeight: AppFont.light,
      ),
    );
  }
}
