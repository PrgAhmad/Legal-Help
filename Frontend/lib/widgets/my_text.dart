import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  String text;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  TextOverflow overflow;
  MyText(
    this.text, {
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign = TextAlign.center,
    this.overflow = TextOverflow.visible,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize ?? 12.5,
        fontWeight: fontWeight,
        color: color ?? Theme.of(context).colorScheme.tertiary,
      ),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
