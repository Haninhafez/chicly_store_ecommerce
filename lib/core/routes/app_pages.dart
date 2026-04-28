import 'package:chicly_store/features/auth/presentation/auth/screens/login_screen.dart';
import 'package:chicly_store/features/auth/presentation/auth/screens/register_screen.dart';
import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:chicly_store/features/auth/presentation/auth/screens/splash_screen.dart';
import 'package:chicly_store/features/cart/screens/cart_screen.dart';
import 'package:chicly_store/features/checkout/model/checkout_args.dart';
import 'package:chicly_store/features/checkout/screens/checkout_screen.dart';
import 'package:chicly_store/features/home/screen/home_body.dart';
import 'package:chicly_store/features/home/screen/home_screen.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:chicly_store/features/product/screens/product_details.dart';
import 'package:chicly_store/features/product/screens/product_screen.dart';
import 'package:chicly_store/features/profile/screens/profile_screens.dart';
import 'package:chicly_store/features/wishlist/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';

class AppPages {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.login: (context) => LoginScreen(),
    AppRoutes.register: (context) => RegisterScreen(),
    AppRoutes.home: (context) => HomeScreen(),
    AppRoutes.cart: (context) => CartScreen(),
    AppRoutes.profile: (context) => ProfileScreens(),
    AppRoutes.wishlist: (context) => WishlistScreen(),
    AppRoutes.products: (context) => ProductScreen(),
    AppRoutes.splash: (context) => SplashScreen(),
    AppRoutes.checkout: (context) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is CheckoutArgs) {
        return CheckoutScreen(
          subTotalAmount: args.totalAmount,
          cartProductItemes: args.cartProudctsItem,
        );
      }

      return CartScreen();
    },
    AppRoutes.productDetails: (context) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is ProductModel) {
        return ProductDetailsScreen(product: args);
      }

      return HomeScreen();
    },
  };
}
