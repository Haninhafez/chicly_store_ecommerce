import 'package:chicly_store/features/auth/presentation/auth/model/user_model.dart';
import 'package:chicly_store/features/auth/presentation/auth/service/firebase_auth_service.dart';
import 'package:chicly_store/features/auth/presentation/auth/widgets/custom_text_field.dart';
import 'package:chicly_store/features/auth/presentation/auth/widgets/password_field.dart';
import 'package:chicly_store/features/auth/presentation/auth/widgets/social_login.dart';
import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/constant/controller_button.dart';
import 'package:chicly_store/core/constant/custom_text_poppins.dart';
import 'package:chicly_store/core/constant/helper.dart';
import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:chicly_store/core/utils/form_validators.dart';
import 'package:chicly_store/core/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rt_awesome_snackbar_content/rt_awesome_snackbar_content.dart';

class CardLogin extends StatefulWidget {
  CardLogin({super.key});

  @override
  State<CardLogin> createState() => _CardLoginState();
}

class _CardLoginState extends State<CardLogin> {
  UserModel userModel = UserModel();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,

      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextPoppins(
              text: "Welcome!",
              color: ColorApp.primayLight,
              fontSize: 30,
            ),
            CustomTextPoppins(
              text: "please login or sign up to continue our app",
              color: ColorApp.darkGray,
            ),

            CustomTextField(
              outlineInputBorder: outlineInputBorder,
              text: "Email",
              validator: (String? value) {
                userModel.email = value;
                return Validators.emailOrPhoneValidator(value);
              },
            ),

            PasswordField(
              text: "Password",
              outlineInputBorder: outlineInputBorder,
              validator: (String? value) {
                userModel.password = value;
                return Validators.password(value);
              },
            ),

            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: ControllerButton(
                text: "Login",
                color: ColorApp.primayLight,
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    
                  final result = await signInFirebase(context, userModel);
                    result ==null?
                    Navigator.pushReplacementNamed(context, AppRoutes.home)
                    : null;
                  }
                },
              ),
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: Divider(thickness: 1, color: ColorApp.darkGray),
                ),
                CustomTextPoppins(
                  text: "OR",
                  color: ColorApp.primayLight,
                  fontWeight: FontWeight.w600,
                ),
                Expanded(
                  child: Divider(thickness: 1, color: ColorApp.darkGray),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: GoogleFonts.poppins(color: ColorApp.darkGray),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.register);
                  },
                  child: CustomTextPoppins(
                    text: "Sign up",
                    color: ColorApp.cusBlue,
                  ),
                ),
              ],
            ),
            SocialLogin(),
          ],
        ),
      ),
    );
  }
}
