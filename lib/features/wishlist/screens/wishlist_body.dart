import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/utils/full_width_card_product.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:chicly_store/features/product/widgets/cart_icon.dart';
import 'package:chicly_store/features/product/widgets/wishlist_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WishListBody extends StatelessWidget {
  const WishListBody({super.key, required this.wishListProducts});

  final List<ProductModel> wishListProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Text("WishList", style: GoogleFonts.acme(fontSize: 35)),
              ),
              SliverList.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: FullWidthCardProduct(
                    productModel: wishListProducts[index],
                    actionWidget: CartIcon(product: wishListProducts[index]),
                  ),
                ),
                itemCount: wishListProducts.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
