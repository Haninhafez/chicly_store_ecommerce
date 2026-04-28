import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/constant/custom_text_style.dart';
import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BestSaleProduct extends StatelessWidget {
  const BestSaleProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;
    return Row(
      children: [
        CustomTextPoppins(
          text: "Best Sale Product",
          color: isDark ? ColorApp.primayDark : ColorApp.primayLight,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.products),
          child: CustomTextPoppins(
            text: "See more",
            color: ColorApp.cusBlue,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
