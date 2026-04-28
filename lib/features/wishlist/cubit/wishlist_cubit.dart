import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chicly_store/core/constant/local_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'wishlist_state.dart';

class WishListCubit extends Cubit<WishlistState> {
  WishListCubit() : super(WishlistInitial());

  List<int> _wishList = [];
  List<int> get wishList => _wishList;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription? _wishlistSubscription;

  Future<void> loadWishlist(String userId) async {
    emit(WishlistLoading());

    try {
      final doc = await firestore.collection('users').doc(userId).get();

      if (doc.exists) {
        List<dynamic> data = doc.data()?['wishlist'] ?? [];
        _wishList = data.map((e) => e as int).toList();
      }

      emit(WishListLoaded(_wishList));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> addProductToWishList(int productId) async {
    final userId = await LocalStorageService.getUserId();
    if (userId == null) return;

    try {
      await firestore.collection('users').doc(userId).set({
        'wishlist': FieldValue.arrayUnion([productId]),
      }, SetOptions(merge: true));

      _wishList.add(productId);

      emit(WishListLoaded(_wishList));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> removeProductFromWishList(int productId) async {
    final userId = await LocalStorageService.getUserId();
    if (userId == null) return;

    try {
      await firestore.collection('users').doc(userId).set({
        'wishlist': FieldValue.arrayRemove([productId]),
      }, SetOptions(merge: true));

      _wishList.remove(productId);

      emit(WishListLoaded(_wishList));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> toggleProduct(int productId) async {
    if (_wishList.contains(productId)) {
      await removeProductFromWishList(productId);
    } else {
      await addProductToWishList(productId);
    }
  }

  bool isInWishList(int productId) {
    return _wishList.contains(productId);
  }

  @override
  Future<void> close() {
    _wishlistSubscription?.cancel();
    return super.close();
  }
}
