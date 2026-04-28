import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:chicly_store/core/utils/snack_bar.dart';
import 'package:chicly_store/features/cart/cubit/cart_shopping_cubit.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:chicly_store/features/product/widgets/cart_controlls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rt_awesome_snackbar_content/rt_awesome_snackbar_content.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;
    return BlocBuilder<CartShoppingCubit, CartShoppingState>(
      builder: (context, state) {
        bool isInCart = false;
        int cartQuantity =
            context.watch<CartShoppingCubit>().cartItem[product.id] ?? 1;

        if (state is CartShoppingLoaded) {
          isInCart = state.cartItems.containsKey(product.id);
          cartQuantity = state.cartItems[product.id] ?? 0;
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (cartQuantity == 0)
                        Text(
                          '${product.price} EGP',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (cartQuantity > 0)
                        Text(
                          '${product.price * cartQuantity} EGP',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),

                Expanded(
                  child: isInCart
                      ? CartControls(product: product)
                      : ElevatedButton(
                          onPressed: () {
                            context.read<CartShoppingCubit>().addProductToCart(
                              product.id,
                            );
                            showSnackBar(
                              context: context,
                              message: "Product added to cart",
                              contentType: ContentType.success,
                              color: ColorApp.cusBlue.withAlpha(80),
                              title: "Added",
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark
                                ? ColorApp.primayDark
                                : ColorApp.primayLight,
                            foregroundColor: isDark
                                ? Colors.black
                                : Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
