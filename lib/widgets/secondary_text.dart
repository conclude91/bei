import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondaryText extends StatefulWidget {
  final String text;
  final double size;

  SecondaryText({@required this.text, @required this.size});

  @override
  _SecondaryTextState createState() => _SecondaryTextState();
}

class _SecondaryTextState extends State<SecondaryText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        color: AppColor.secondaryTextColor,
        fontSize: widget.size,
        fontWeight: AppFont.light,
      ),
    );
  }
}
