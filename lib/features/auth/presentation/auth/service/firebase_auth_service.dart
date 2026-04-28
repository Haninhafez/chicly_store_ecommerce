// ignore_for_file: use_build_context_synchronously

import 'package:chicly_store/features/auth/presentation/auth/model/user_model.dart';
import 'package:chicly_store/core/constant/local_storage_service.dart';
import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:chicly_store/core/utils/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> createAccount(BuildContext context, UserModel userModel) async {
  try {
    final credentialUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: userModel.email!,
          password: userModel.password!,
        );
    final user = credentialUser.user;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'userName': userModel.userName,
      'email': userModel.email,
      'userPhone': userModel.phone,
   

      'createdAt': FieldValue.serverTimestamp(),
    });
    String? token = await user.getIdToken(true);
    await LocalStorageService.saveLogin(
      userId: user.uid,
      userName: userModel.userName!,
      userEmail: userModel.email!,
      isLoggedIn: true,
      accessToken: token!,
      userPhone: userModel.phone ?? "",
    );

    return null;
  } on FirebaseAuthException catch (e) {
    return e.toString();
  } catch (e) {
    return e.toString();
  }
}

Future<void> logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();

    await LocalStorageService.clear();

    Navigator.pushReplacementNamed(context, AppRoutes.login);
  } catch (e) {
    showSnackBar(context: context, message: e.toString());
  }
}

Future<String?> signInFirebase(
  BuildContext context,
  UserModel userModel,
) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: userModel.email ?? "",
      password: userModel.password ?? "",
    );
    final user = credential.user;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    if (userDoc.exists) {
      String? token = await user.getIdToken(true);
      if (token != null) {
        await LocalStorageService.saveLogin(
          userId: user.uid,
          userName: userDoc['userName'],
          userEmail: userDoc['email'],
          isLoggedIn: true,
          accessToken: token,
          userPhone: userDoc['userPhone'] ?? "",
        );
        return null;
      } else {
        showSnackBar(context: context, message: "Token is null");
      }
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-credential') {
      showSnackBar(context: context, message: 'Invalid credential');
    } else if (e.code == 'user-not-found') {
      showSnackBar(context: context, message: 'User not found');
    } else if (e.code == 'user-disabled') {
      showSnackBar(context: context, message: 'This account has been disabled');
    } else {
      showSnackBar(
        context: context,
        message: e.message ?? 'Authentication error',
      );
    }
    return e.message;
  } catch (e) {
    showSnackBar(context: context, message: e.toString());
    return e.toString();
  }
}

Future<UserCredential?> signInWithFacebook(BuildContext context) async {
  try {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status != LoginStatus.success) {
      print("Facebook login failed");
      return null;
    }
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    final user = userCredential.user!;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'userName': user.displayName,
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      String? token = await user.getIdToken(true);
      await LocalStorageService.saveLogin(
        userId: user.uid,
        userName: user.displayName!,
        userEmail: user.email!,
        isLoggedIn: true,
        accessToken: token!,
        userPhone: user.phoneNumber ?? "",
      );

      Navigator.pushReplacementNamed(context, AppRoutes.home);
      return userCredential;
    } else {
      return null;
    }
  } on Exception catch (e) {
    showSnackBar(context: context, message: "${e.toString()}");
  }
}

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    User user = userCredential.user!;
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'userName': user.displayName,
      'email': user.email,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    String? token = await user.getIdToken(true);
    await LocalStorageService.saveLogin(
      userId: user.uid,
      userName: user.displayName!,
      userEmail: user.email!,
      isLoggedIn: true,
      accessToken: token!,
      userPhone: user.phoneNumber ?? "",
    );

    Navigator.pushReplacementNamed(context, AppRoutes.home);
  } catch (e) {
    showSnackBar(context: context, message: e.toString());
  }
}
