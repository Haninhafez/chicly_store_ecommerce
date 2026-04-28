import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:chicly_store/core/utils/full_width_card_product.dart';
import 'package:chicly_store/features/cart/widgets/action_cart.dart';
import 'package:chicly_store/features/checkout/model/checkout_args.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartBody extends StatelessWidget {
  const CartBody({
    super.key,
    required this.cartProducts,
    required this.cartItems,
    required this.totalPrice,
    this.issuccess = false,
  });

  final List<ProductModel> cartProducts;
  final Map<int, int> cartItems;
  final double totalPrice;
  final bool issuccess;

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "CartShopping",
                    style: GoogleFonts.acme(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    child: Text(
                      "Total: ${totalPrice.toStringAsFixed(0)}",
                      style: GoogleFonts.acme(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: cartProducts.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: FullWidthCardProduct(
                    productModel: cartProducts[index],
                    actionWidget: ActionInCart(product: cartProducts[index]),
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: () => issuccess
                  ? Navigator.pushNamed(
                      context,
                      AppRoutes.checkout,
                      arguments: CheckoutArgs(
                        totalAmount: totalPrice,
                        cartProudctsItem: cartItems,
                      ),
                    )
                  : null,
              child: Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: ColorApp.cusBlue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: issuccess
                      ? Text(
                          "Checkout",
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        )
                      : CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
