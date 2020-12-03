import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisableText extends StatefulWidget {
  final String text;
  final double size;

  DisableText({@required this.text, @required this.size});

  @override
  _DisableTextState createState() => _DisableTextState();
}

class _DisableTextState extends State<DisableText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        color: disableTextColor,
        fontSize: widget.size,
        fontWeight: fontlight,
      ),
    );
  }
}
