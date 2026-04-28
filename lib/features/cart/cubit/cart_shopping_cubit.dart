import 'package:bloc/bloc.dart';
import 'package:chicly_store/core/constant/local_storage_service.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'cart_shopping_state.dart';

class CartShoppingCubit extends Cubit<CartShoppingState> {
  CartShoppingCubit() : super(CartShoppingInitial());

  Map<int, int> cartItem = {};


  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> loadCartProduct(String userId) async {
    emit(CartShoppingLoading());

    try {
      final doc = await firestore.collection('users').doc(userId).get();

      if (doc.exists) {
        Map<String, dynamic> cartData = doc.data()?['cartShopping'];
        if (cartData != null && cartData is Map<String, dynamic>) {
          cartItem = cartData.map((key, value) {
            return MapEntry(int.parse(key.toString()), value as int);
          });
        }
      } else {
        cartItem = {};
      }

      emit(CartShoppingLoaded(cartItems: cartItem));
    } catch (e) {
      emit(CartShoppingError(message: e.toString()));
    }
  }

  Future<void> addProductToCart(int productId, {int quantity = 1}) async {
    final userId = await LocalStorageService.getUserId();
    if (userId == null) return;

    try {
      if (cartItem.containsKey(productId)) {
        cartItem[productId] = cartItem[productId]! + quantity;
      } else {
        cartItem[productId] = quantity;
      }
      await _updateCartInFirestore(userId);

      emit(CartShoppingLoaded(cartItems: cartItem));
    } catch (e) {
      emit(CartShoppingError(message: e.toString()));
    }
  }

  Future<void> removeProductFromCart(int productId) async {
    final userId = await LocalStorageService.getUserId();
    if (userId == null) return;

    try {
      cartItem.remove(productId);
  
      await _updateCartInFirestore(userId);

      emit(CartShoppingLoaded(cartItems: cartItem));
    } catch (e) {
      emit(CartShoppingError(message: e.toString()));
    }
  }

  Future<void> _updateCartInFirestore(String userId) async {
    final firestoreData = cartItem.map((key, value) {
      return MapEntry(key.toString(), value);
    });
    await firestore.collection('users').doc(userId).set({
      'cartShopping': firestoreData,
    }, SetOptions(merge: true));
  }

 

  bool isInCart(int productId) {
    return cartItem.containsKey(productId);
  }

  //Quantity

  Future<void> incrementQuantity(int productId) async {
    if (cartItem.containsKey(productId)) {
      int newQuantity = cartItem[productId]! + 1;
      await updateProductQuantity(productId, newQuantity);
    }
  }

  Future<void> decrementQuantity(int productId) async {
    if (cartItem.containsKey(productId)) {
      int currentQuantity = cartItem[productId]!;
      if (currentQuantity < 1) {
        await removeProductFromCart(productId);
      } else {
        await updateProductQuantity(productId, currentQuantity - 1);
      }
    }
  }

  Future<void> updateProductQuantity(int productId, int quantity) async {
    if (quantity <= 0) {
      await removeProductFromCart(productId);
      return;
    }

    final userId = await LocalStorageService.getUserId();
    if (userId == null) return;

    try {
      cartItem[productId] = quantity;
      await _updateCartInFirestore(userId);
      emit(CartShoppingLoaded(cartItems: cartItem));
    } catch (e) {
      emit(CartShoppingError(message: e.toString()));
    }
  }



}
