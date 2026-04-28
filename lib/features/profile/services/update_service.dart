import 'package:chicly_store/core/constant/local_storage_service.dart';
import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:chicly_store/core/utils/snack_bar.dart';
import 'package:chicly_store/features/auth/presentation/auth/service/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rt_awesome_snackbar_content/rt_awesome_snackbar_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateService {
  static Future<void> updateName(String name) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || name.isEmpty) return;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'userName': name,
    });

    await LocalStorageService.saveName(name);
  }

  static Future<void> updateEmail(
    BuildContext context,
    String password,
    String newEamil,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    final emailUser = user!.email;
    if (user == null || password.isEmpty) return;
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: emailUser!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      await user.verifyBeforeUpdateEmail(newEamil);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Check your email to verify your new email address 📩"),
        ),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({'email': newEamil});
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static Future<void> updatePhone(String phone) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || phone.isEmpty) return;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'userPhone': phone,
    });

    await LocalStorageService.savePhone(phone);
  }

  static Future<void> resetPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Check your email to reset password 📩")),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Error")));
    }
  }

  static Future<void> deleteAccountUserCreated(
    BuildContext context,
    String password,
  ) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null || password.isEmpty) return;

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);

      await user.delete();

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();
      Navigator.pushReplacementNamed(context, AppRoutes.login);

      showSnackBar(
        context: context,
        message: "Account deleted successfully",
        title: "Delete Account",
        contentType: ContentType.warning,
        color: Colors.orangeAccent,
      );
    } on FirebaseAuthException catch (e) {
      String message = "Something went wrong";

      if (e.code == 'wrong-password') {
        message = "Wrong password";
      } else if (e.code == 'requires-recent-login') {
        message = "Please login again";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static Future<String> KnowKindOfLogin(
    BuildContext context,
   
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return"";
    if(user.providerData[0].providerId=="google.com"){
      return "google";
    }
    else {
      return "email";
    }
  
  }

  static Future<void> deleteGoogleUser(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        showSnackBar(context: context, message: "NO user logged in");
        return;
      }
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 🔐 NOW SAFE TO USE USER
      await user.reauthenticateWithCredential(credential);

      await user.delete();

      await LocalStorageService.clear();
      await GoogleSignIn().signOut();
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      showSnackBar(
        context: context,
        message: "Account deleted successfully",
        title: "Delete Account",
        contentType: ContentType.warning,
        color: Colors.orangeAccent,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Please login again")));
      }
    }
  }
}
