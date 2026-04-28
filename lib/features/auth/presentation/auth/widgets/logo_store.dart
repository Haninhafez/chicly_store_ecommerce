import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class LogoStore extends StatelessWidget {
   LogoStore({super.key, this.color = Colors.white});
  Color color ;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Chicly Store",
      style: GoogleFonts.meaCulpa(
        fontSize: 40,
        color:color,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
