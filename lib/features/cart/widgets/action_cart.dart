import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:chicly_store/features/cart/cubit/cart_shopping_cubit.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ActionInCart extends StatelessWidget {
  const ActionInCart({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? ColorApp.primayLight
            : Color.fromARGB(14, 148, 148, 148),
        border: Border.all(color: ColorApp.darkGray, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              context.read<CartShoppingCubit>().addProductToCart(product.id);
            },
            icon: Icon(
              Icons.add,
              // color: isDark ? ColorApp.primayDark : ColorApp.primayLight,
            ),
          ),

          SizedBox(width: 5),

          Text(
            "${context.watch<CartShoppingCubit>().cartItem[product.id]}",
            style: GoogleFonts.acme(fontSize: 20),
          ),
          SizedBox(width: 5),
          IconButton(
            onPressed: () {
              context.read<CartShoppingCubit>().decrementQuantity(product.id);
            },
            icon: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
