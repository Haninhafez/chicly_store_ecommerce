import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/utils/snack_bar.dart';
import 'package:chicly_store/features/auth/presentation/auth/widgets/logo_store.dart';
import 'package:chicly_store/features/cart/cubit/cart_shopping_cubit.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:chicly_store/features/product/widgets/add_to_cart_button.dart';
import 'package:chicly_store/features/product/widgets/build_image_product.dart';
import 'package:chicly_store/features/product/widgets/product_details.dart';
import 'package:chicly_store/features/product/widgets/wishlist_icon.dart';
import 'package:chicly_store/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 400,
              pinned: true,
              floating: true,

              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back, ),
                ),
              ),
              actions: [
                WishlistIcon(id: widget.product.id),
                const SizedBox(width: 8),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: BuildImageProduct(product: widget.product),
              ),
            ),

            SliverToBoxAdapter(child: ProductDetails(product: widget.product)),

            SliverFillRemaining(
              hasScrollBody: false,
              child: AddToCartButton(product: widget.product),
            ),
          ],
        ),
      ),
    );
  }
}
