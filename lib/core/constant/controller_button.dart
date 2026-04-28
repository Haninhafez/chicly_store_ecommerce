import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ControllerButton extends StatelessWidget {
  ControllerButton({
    super.key,

    required this.text,
    required this.color,
    required this.onTap,
    this.borderColor = Colors.transparent,
    this.textColor = Colors.white,
  });
  final String text;
  final Color color;
  Color textColor;
  Color borderColor;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
            border: BoxBorder.all(color: borderColor, width: 2),
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
