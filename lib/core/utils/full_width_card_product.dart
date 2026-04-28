import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:chicly_store/features/product/widgets/wishlist_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullWidthCardProduct extends StatelessWidget {
  const FullWidthCardProduct({
    super.key,
    required this.productModel,
    required this.actionWidget,
  });
  final ProductModel productModel;
  final Widget actionWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.productDetails,
        arguments: productModel,
      ),
      child: Container(
        height: height * 0.13,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isDark ? ColorApp.primayLight : ColorApp.primayDark,
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.grey : Colors.black12,
              blurRadius: 4,
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.10,

                  child: Image.network(
                    productModel.images[0].url,
                    fit: BoxFit.fill,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          productModel.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: isDark
                                ? ColorApp.primayDark
                                : ColorApp.primayLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Row(
                          children: [
                            Column(
                              spacing: 5,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star, color: ColorApp.yellow),
                                    SizedBox(width: 5),
                                    Text(
                                      "4.5",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: isDark
                                            ? ColorApp.darkGrayDark
                                            : ColorApp.darkGray,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${productModel.price} EGP",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: isDark
                                        ? ColorApp.cusBlueDark
                                        : ColorApp.cusBlue,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Align(
                              alignment: AlignmentGeometry.bottomRight,
                              child: actionWidget,
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: -5,
              left: -15,
              child: WishlistIcon(id: productModel.id),
            ),
          ],
        ),
      ),
    );
  }
}
