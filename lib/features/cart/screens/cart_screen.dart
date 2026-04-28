import 'package:chicly_store/core/utils/shimmer_loading_body.dart';
import 'package:chicly_store/core/constant/local_storage_service.dart';
import 'package:chicly_store/features/auth/presentation/auth/widgets/logo_store.dart';
import 'package:chicly_store/features/cart/cubit/cart_shopping_cubit.dart';
import 'package:chicly_store/features/cart/screens/cart_body.dart';
import 'package:chicly_store/core/utils/product_grid_card.dart';
import 'package:chicly_store/features/product/cubit/product_cubit.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? userId;
  List<ProductModel>? cartProducts;
  Map<int, int>? cartItems; // Map of productId to quantity>
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    userId = await LocalStorageService.getUserId();
    if (userId != null && mounted) {
      context.read<CartShoppingCubit>().loadCartProduct(userId!);
      context.read<ProductCubit>().getProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<CartShoppingCubit>()),
        BlocProvider.value(value: context.read<ProductCubit>()),
      ],
      child: BlocListener<CartShoppingCubit, CartShoppingState>(
        listener: (context, state) {
          if (state is CartShoppingLoaded && userId != null) {
            context.read<ProductCubit>().getProducts();
          }
        },
        child: BlocBuilder<CartShoppingCubit, CartShoppingState>(
          builder: (context, state) {
            if (state is CartShoppingLoading || userId == null) {
              if (cartProducts != null) {
                return Scaffold(
                  body: CartBody(
                    cartProducts: cartProducts!,
                    cartItems: cartItems!,
                    totalPrice: 0,
                  ),
                );
              }
              return ShimmerLoadingBody();
            }
            if (state is CartShoppingError) {
              return Scaffold(body: Center(child: Text('No Product in cart')));
            }

            if (state is CartShoppingLoaded) {
              return BlocBuilder<ProductCubit, ProductState>(
                builder: (context, productState) {
                  if (productState is ProductLoading) {
                    if (cartProducts != null) {
                      return CartBody(
                        cartProducts: cartProducts!,
                        cartItems: cartItems!,
                        totalPrice: totalPrice,
                      );
                    }
                    return ShimmerLoadingBody();
                  }
                  if (productState is ProductSuccess) {
                    cartItems = state.cartItems;
                    cartProducts = productState.products
                        .where((p) => cartItems!.containsKey(p.id))
                        .toList();

                    for (var product in cartProducts!) {
                      final quantity = state.cartItems[product.id] ?? 0;
                      totalPrice += product.price * quantity;
                    }

                    if (cartProducts!.isEmpty) {
                      return const Scaffold(
                        body: Center(child: Text("No products in wishlist")),
                      );
                    }
                    return Scaffold(
                      body: CartBody(
                        cartProducts: cartProducts!,
                        cartItems: state.cartItems,
                        totalPrice: totalPrice,
                        issuccess: true,
                      ),
                    );
                  }
                  return const Scaffold(
                    body: Center(child: Text("No products loaded")),
                  );
                },
              );
            }

            return const Scaffold(
              body: Center(child: Text("No products in wishlist")),
            );
          },
        ),
      ),
    );
  }
}
