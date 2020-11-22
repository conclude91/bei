import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryText extends StatefulWidget {
  final String text;
  final double size;
  final int maxLine;
  final Color color;

  PrimaryText(
      {@required this.text, @required this.size, this.maxLine, this.color});

  @override
  _PrimaryTextState createState() => _PrimaryTextState();
}

class _PrimaryTextState extends State<PrimaryText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        color:
            (widget.color != null) ? widget.color : AppColor.primaryTextColor,
        fontSize: widget.size,
        fontWeight: AppFont.light,
      ),
      maxLines: (widget.maxLine != null) ? widget.maxLine : null,
      overflow: (widget.maxLine != null) ? TextOverflow.ellipsis : null,
    );
  }
}
