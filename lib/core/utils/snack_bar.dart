import 'package:chicly_store/core/constant/color_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rt_awesome_snackbar_content/rt_awesome_snackbar_content.dart';


final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void showSnackBar({
  required BuildContext context,
  required String message,
  ContentType contentType = ContentType.failure,
  Color? color,
  String title = "Failure",
}) {
   final messenger = rootScaffoldMessengerKey.currentState;
  if (messenger == null) return;
  messenger.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: AwesomeSnackbarContent(
        inMaterialBanner: false,
        title: title,
        message: message,

        contentType: contentType,
        color: color ?? ColorApp.error,
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}
