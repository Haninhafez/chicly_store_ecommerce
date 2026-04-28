import 'package:chicly_store/features/auth/presentation/auth/widgets/card_create_an_account.dart';
import 'package:chicly_store/features/auth/presentation/auth/widgets/logo_store.dart';
import 'package:chicly_store/core/constant/helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              height: MediaQuery.of(context).size.height * 0.2,
              child: LogoStore(),
            ),
            Expanded(
              child: CardCreateAnAccount(
                outlineInputBorder: outlineInputBorder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
