

import 'package:chicly_store/core/utils/full_width_card_product_shimmer.dart';
import 'package:chicly_store/core/utils/shimmer_loading_body.dart';
import 'package:chicly_store/core/constant/local_storage_service.dart';
import 'package:chicly_store/features/auth/presentation/auth/widgets/logo_store.dart';
import 'package:chicly_store/core/utils/product_grid_card.dart';
import 'package:chicly_store/features/product/cubit/product_cubit.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:chicly_store/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:chicly_store/features/wishlist/screens/wishlist_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  String? userId;
   List<ProductModel>? wishListProducts ;
   List<ProductModel>? products;

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
      context.read<WishListCubit>().loadWishlist(userId!);
      context.read<ProductCubit>().getProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<WishListCubit>()),
        BlocProvider.value(value: context.read<ProductCubit>()),
      ],
      child: BlocListener<WishListCubit, WishlistState>(
        listener: (context, state) {
          if (state is WishListLoaded && userId != null) {
            context.read<ProductCubit>().getProducts();
          }
        },
        child: BlocBuilder<WishListCubit, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading || userId == null) {
              if(wishListProducts != null){
                return WishListBody(wishListProducts: wishListProducts!);
              }
              return  ShimmerLoadingBody();
            }
            if (state is WishlistError) {
              return Scaffold(body: Center(child: Text(state.message)));
            }

            if (state is WishListLoaded) {
              return BlocBuilder<ProductCubit, ProductState>(
                builder: (context, productState) {
                  if (productState is ProductLoading) {
                    if
                    (wishListProducts != null){
                      return WishListBody(wishListProducts: wishListProducts!);
                    }
                    return ShimmerLoadingBody();
                  }
                  if (productState is ProductSuccess) {
                    products = productState.products;
                    wishListProducts = products!
                        .where((p) => state.ProductId.contains(p.id))
                        .toList();

                    if (wishListProducts!.isEmpty) {
                      return const Scaffold(
                        body: Center(child: Text("No products in wishlist")),
                      );
                    }
                    return
                     WishListBody(wishListProducts: wishListProducts!,
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

