import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/theme/theme_data.dart';
import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:chicly_store/core/utils/snack_bar.dart';
import 'package:chicly_store/core/constant/local_storage_service.dart';
import 'package:chicly_store/core/routes/app_pages.dart';
import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:chicly_store/features/cart/cubit/cart_shopping_cubit.dart';
import 'package:chicly_store/features/checkout/stripe_payment/keys.env';
import 'package:chicly_store/features/home/screen/home_screen.dart';
import 'package:chicly_store/features/product/cubit/product_cubit.dart';
import 'package:chicly_store/features/product/service/get_product.dart';
import 'package:chicly_store/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:chicly_store/firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = StripeKeys.publicKey;
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalStorageService.init();
final themeNotifier = ThemeNotifier();
  await themeNotifier.loadTheme();

  runApp(
    ChangeNotifierProvider(
      create: (_) => themeNotifier,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<bool> isUserLoggedIn() async {
    return LocalStorageService.isUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit()..getProducts()),
        BlocProvider(create: (context) => WishListCubit()),
        BlocProvider(create: (Context) => CartShoppingCubit()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          bool isDarkMode = themeNotifier.isDarkMode;
          return MaterialApp(
            scaffoldMessengerKey: rootScaffoldMessengerKey,
            darkTheme: darkTheme,
            theme: lightTheme,
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.splash,
            routes: AppPages.routes,
          );
        },
      ),
    );
  }
}
