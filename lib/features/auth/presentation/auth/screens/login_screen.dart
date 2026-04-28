import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:chicly_store/core/constant/local_storage_service.dart';
import 'package:chicly_store/features/auth/presentation/auth/widgets/card_login.dart';
import 'package:chicly_store/features/auth/presentation/auth/widgets/logo_store.dart';
import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/constant/helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   
  
 
  @override
  Widget build(BuildContext context) {
   

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(height: 100),
            LogoStore(),
            SizedBox(height: 100),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: boxDecoration,

                child: CardLogin(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
