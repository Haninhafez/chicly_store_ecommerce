part of 'wishlist_cubit.dart';

sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoading extends WishlistState {}

final class WishListLoaded extends WishlistState {
  final List<int> ProductId;
  WishListLoaded(this.ProductId);
}

final class WishlistError extends WishlistState {
  final String message;
  WishlistError(this.message);
}