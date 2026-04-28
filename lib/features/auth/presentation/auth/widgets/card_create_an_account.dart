import 'package:chicly_store/features/auth/presentation/auth/model/user_model.dart';
import 'package:chicly_store/features/auth/presentation/auth/service/firebase_auth_service.dart';
import 'package:chicly_store/features/auth/presentation/auth/widgets/custom_text_field.dart';
import 'package:chicly_store/features/auth/presentation/auth/widgets/password_field.dart';
import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/constant/controller_button.dart';
import 'package:chicly_store/core/constant/custom_text_style.dart';
import 'package:chicly_store/core/constant/helper.dart';
import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:chicly_store/core/utils/form_validators.dart';
import 'package:chicly_store/core/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rt_awesome_snackbar_content/rt_awesome_snackbar_content.dart';

class CardCreateAnAccount extends StatefulWidget {
  CardCreateAnAccount({super.key, required this.outlineInputBorder});

  final OutlineInputBorder outlineInputBorder;

  @override
  State<CardCreateAnAccount> createState() => _CardCreateAnAccountState();
}

class _CardCreateAnAccountState extends State<CardCreateAnAccount> {
  UserModel userModel = UserModel();
  bool isChecked = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
    });
    return isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: boxDecoration,

        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            children: [
              SizedBox(height: 15),
              CustomTextField(
                outlineInputBorder: widget.outlineInputBorder,
                text: "User Name",
                validator: (String? value) {
                  userModel.userName = value;
                  return Validators.name(userModel.userName);
                },
              ),

              CustomTextField(
                outlineInputBorder: outlineInputBorder,
                text: 'Phone',
                validator: (String? value) {
                  userModel.phone = value;
                  return Validators.phoneValidator(value);
                },
              ),
              CustomTextField(
                outlineInputBorder: widget.outlineInputBorder,
                text: "Email",
                validator: (String? value) {
                  userModel.email = value;
                  return Validators.email(userModel.email);
                },
              ),
              PasswordField(
                text: "Password",
                outlineInputBorder: widget.outlineInputBorder,
                validator: (String? value) {
                  userModel.password = value;
                  return Validators.password(userModel.password);
                },
              ),
              PasswordField(
                text: "Confirm Password",
                outlineInputBorder: outlineInputBorder,
                validator: (String? value) {
                  return Validators.confirmPasswordValidator(
                    password: userModel.password,
                    confirmPassword: value,
                  );
                },
              ),

              CheckboxListTile(
                value: isChecked,

                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
                activeColor: ColorApp.primayLight,
                checkColor: ColorApp.white,
                title: CustomTextPoppins(
                  text: "I agree to the terms & conditions",
                  color: ColorApp.darkGray,
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              ControllerButton(
                text: "CREATE AN ACCOUNT",
                color: toggleCheckbox() ? ColorApp.grey : ColorApp.primayLight,

                onTap: toggleCheckbox()
                    ? () async {
                        if (formKey.currentState!.validate()) {
                          final result = await createAccount(
                            context,
                            userModel,
                          );

                          if (result == null) {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.home,
                            );
                          } else if (result == "email-already-in-use") {
                            showSnackBar(
                              context: context,
                              message: "Account already exists",
                            );
                          } else if (result == "weak-password") {
                            showSnackBar(
                              context: context,
                              message: "Weak password",
                            );
                          } else {
                            showSnackBar(
                              context: context,
                              message: "Something went wrong",
                            );
                          }
                        }
                      }
                    : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do you have an account?",
                    style: GoogleFonts.poppins(color: ColorApp.darkGray),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    child: CustomTextPoppins(
                      text: "Sign In",
                      color: ColorApp.cusBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
