import 'package:chicly_store/core/utils/snack_bar.dart';
import 'package:chicly_store/core/constant/local_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

void addProductWishlist(int productId,BuildContext context) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(LocalStorageService.userId).set({
      'wishlist': [productId],
    }, SetOptions(merge: true));
  } catch (e) {
    showSnackBar(context: context, message: e.toString());
  }
}

void removeProductWishlist(
  int productId,
  BuildContext context,
) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(LocalStorageService.userId).update({
      'wishlist': FieldValue.arrayRemove([productId]),
    });
  } catch (e) {
    showSnackBar(context: context, message: e.toString());
  }
}

Future<List<int>> getWishlist( BuildContext context) async {
  try {
    var userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(LocalStorageService.userId)
        .get();

    if (userDoc.exists && userDoc.data()!.containsKey('wishlist')) {
      return List<int>.from(userDoc['wishlist']);
    } else {
      return [];
    }
  } catch (e) {
    showSnackBar(context: context, message: e.toString());
    return [];
  }
}
