import 'dart:ui';
import 'package:chicly_store/features/auth/presentation/auth/screens/login_screen.dart';
import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/constant/controller_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showCongrats({required BuildContext context, required String name}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Stack(
        alignment: Alignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(color: const Color(0xff928F8F).withOpacity(0.2)),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(width: double.infinity, height: 15),
                    Text(
                      "Congratulations",
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: ColorApp.primayLight,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      name,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff7A1E76),
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ControllerButton(
                        text: "SIGN IN",
                        color: ColorApp.primayLight,
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    },
  );

  Future.delayed(Duration(seconds: 3), () {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  });
}
