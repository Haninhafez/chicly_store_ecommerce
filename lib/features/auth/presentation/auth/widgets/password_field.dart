import 'package:chicly_store/features/auth/presentation/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  PasswordField({
    super.key,
    required this.outlineInputBorder,
    required this.validator,
    required this.text,
  });

  final OutlineInputBorder outlineInputBorder;
  final String? Function(String?)? validator;
  final String text;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      outlineInputBorder: widget.outlineInputBorder,
      text: widget.text,
      isPassword: isPassword,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            isPassword = !isPassword;
          });
        },
        icon: isPassword
            ? Icon(Icons.visibility_off_outlined, color: Colors.grey, size: 20)
            : Icon(Icons.remove_red_eye_outlined, color: Colors.grey, size: 20),
      ),
      validator: widget.validator,
    );
  }
}
