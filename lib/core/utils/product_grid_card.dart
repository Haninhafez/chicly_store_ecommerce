import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:chicly_store/features/cart/cubit/cart_shopping_cubit.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:chicly_store/features/product/screens/product_details.dart';
import 'package:chicly_store/features/product/widgets/cart_icon.dart';
import 'package:chicly_store/features/product/widgets/wishlist_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ProductGridCard extends StatelessWidget {
  ProductGridCard({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.productDetails,
          arguments: productModel,
        ),
        child: Container(
          height: height * 0.20,

          decoration: BoxDecoration(
            color: isDark ? ColorApp.primayLight : ColorApp.primayDark,
            boxShadow: [
              BoxShadow(
                color: isDark ?Colors.white70 : Color.fromARGB(60, 0, 0, 0),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  productModel.images[0].url,
                  height: height * 0.1,

                  errorBuilder: (context, error, stackTrace) {
                    return Image(
                      image: AssetImage("assets/images/errorImage.png"),
                    );
                  },
                ),
              ),
              Positioned(
                top: 2,
                right: 0,
                child: WishlistIcon(id: productModel.id),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AspectRatio(
                  aspectRatio: 1.9,
                  child: ProductInfo(productModel: productModel),
                ),
              ),
              Positioned(
                right: 5,
                bottom: 110,
                child: CartIcon(product: productModel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;
    return Container(
      color: isDark ? ColorApp.primayLight : ColorApp.primayDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              productModel.title,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Row(
              children: [
                Icon(Icons.star, color: ColorApp.yellow),
                SizedBox(width: 5),
                Text(
                  "4.5",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: ColorApp.darkGrayDark,
                  ),
                ),
                Spacer(),

                Text(
                  "${productModel.price} EGP",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: ColorApp.cusBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
