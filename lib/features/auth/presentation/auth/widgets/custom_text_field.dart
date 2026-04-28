import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/constant/custom_text_poppins.dart';
import 'package:chicly_store/core/constant/helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.outlineInputBorder,
    required this.text,

    this.isPassword = false,
    this.suffixIcon,
    this.hintText = '',
    required this.validator,
  });

  final OutlineInputBorder outlineInputBorder;
  final String text;
  bool isPassword;
  Widget? suffixIcon;
  final String? Function(String?)? validator;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      obscureText: isPassword,
      obscuringCharacter: '*',

      style: GoogleFonts.dmSans(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      validator: validator,
      decoration: InputDecoration(
        labelStyle: TextStyle(),
        label: CustomTextPoppins(
          text: text,
          color: ColorApp.primayLight,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }
}
