import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatefulWidget {
  final String text;
  final double size;
  final int maxLine;
  final Color color;
  final FontWeight weight;

  CustomText({
    @required this.text,
    @required this.size,
    this.maxLine,
    this.color,
    this.weight,
  });

  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.ubuntu(
        color: (widget.color != null) ? widget.color : primaryTextColor,
        fontSize: widget.size,
        fontWeight: widget.weight != null ? widget.weight : fontlight,
      ),
      maxLines: (widget.maxLine != null) ? widget.maxLine : null,
      overflow: (widget.maxLine != null) ? TextOverflow.ellipsis : null,
    );
  }
}
