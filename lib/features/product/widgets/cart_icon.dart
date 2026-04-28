import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:chicly_store/core/utils/snack_bar.dart';
import 'package:chicly_store/features/cart/cubit/cart_shopping_cubit.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rt_awesome_snackbar_content/rt_awesome_snackbar_content.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;
    return Container(
      child: BlocBuilder<CartShoppingCubit, CartShoppingState>(
        builder: (context, state) {
          return Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(14, 148, 148, 148),
              border: Border.all(color: ColorApp.darkGray, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                context.read<CartShoppingCubit>().addProductToCart(product.id);
                showSnackBar(
                  context: context,
                  message: "Product added to cart",
                  contentType: ContentType.success,
                  color: ColorApp.cusBlue.withAlpha(80),
                  title: "Added",
                );
              },
              child: Icon(
                Icons.add_shopping_cart_outlined,
                color: isDark ? ColorApp.primayDark : ColorApp.primayLight,
              ),
            ),
          );
        },
      ),
    );
  }
}
