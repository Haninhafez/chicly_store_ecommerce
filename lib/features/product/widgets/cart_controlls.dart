import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:chicly_store/features/cart/cubit/cart_shopping_cubit.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CartControls extends StatefulWidget {
  const CartControls({super.key, required this.product});
  final ProductModel product;

  @override
  State<CartControls> createState() => _CartControlsState();
}

class _CartControlsState extends State<CartControls> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;
    int cartQuantity =
        context.read<CartShoppingCubit>().cartItem[widget.product.id] ?? 1;
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark ? ColorApp.white : ColorApp.primayDark,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: () {
                context.read<CartShoppingCubit>().decrementQuantity(
                  widget.product.id,
                );
              },
              icon: cartQuantity > 1
                  ? Icon(Icons.remove, size: 20)
                  : const Icon(
                      Icons.delete_outline,
                      size: 20,
                      color: Colors.red,
                    ),
            ),
          ),

          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              '$cartQuantity',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: IconButton(
              onPressed: () {
                context.read<CartShoppingCubit>().incrementQuantity(
                  widget.product.id,
                );
              },
              icon: const Icon(Icons.add, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
