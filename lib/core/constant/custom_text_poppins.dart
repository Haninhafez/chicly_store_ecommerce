import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextPoppins extends StatelessWidget {
  CustomTextPoppins({
    super.key,
    required this.text,
    required this.color,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
  });
  final String text;
  final Color color;
  final double? fontSize;
  FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: TextAlign.start,
    );
  }
}
