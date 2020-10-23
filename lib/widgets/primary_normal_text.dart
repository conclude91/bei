import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryNormalText extends StatefulWidget {
  final String text;

  PrimaryNormalText(this.text);

  @override
  _PrimaryNormalTextState createState() => _PrimaryNormalTextState();
}

class _PrimaryNormalTextState extends State<PrimaryNormalText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      this.widget.text,
      style: GoogleFonts.poppins(
        color: AppColor.primaryTextColor,
        fontSize: AppDimen.normal,
        fontWeight: AppFont.light,
      ),
    );
  }
}
