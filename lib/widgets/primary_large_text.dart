import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryLargeText extends StatefulWidget {
  final String text;

  PrimaryLargeText(this.text);

  @override
  _PrimaryLargeTextState createState() => _PrimaryLargeTextState();
}

class _PrimaryLargeTextState extends State<PrimaryLargeText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      this.widget.text,
      style: GoogleFonts.poppins(
        color: AppColor.primaryTextColor,
        fontSize: AppDimen.large,
        fontWeight: AppFont.medium,
      ),
    );
  }
}
