part of 'cart_shopping_cubit.dart';

sealed class CartShoppingState {}

final class CartShoppingInitial extends CartShoppingState {}

final class CartShoppingLoaded extends CartShoppingState {
  final Map<int, int> cartItems;

  CartShoppingLoaded({required this.cartItems});
}

final class CartShoppingLoading extends CartShoppingState {}

final class CartShoppingError extends CartShoppingState {
  final String message;
  CartShoppingError({required this.message});
}
