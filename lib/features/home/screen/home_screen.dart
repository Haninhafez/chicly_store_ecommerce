import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:chicly_store/features/cart/screens/cart_screen.dart';
import 'package:chicly_store/features/home/screen/home_body.dart';
import 'package:chicly_store/features/product/cubit/product_cubit.dart';
import 'package:chicly_store/features/profile/screens/profile_screens.dart';
import 'package:chicly_store/features/wishlist/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;
    final List<Widget> pages = [
      HomeBodyScreen(),
      CartScreen(),
      WishlistScreen(),
      ProfileScreens(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],

      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isDark ? ColorApp.primayLight : ColorApp.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(60, 0, 0, 0),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: NavigationBar(
          height: 65,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },

          backgroundColor: Colors.transparent,
          indicatorColor: Colors.transparent,

          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: ColorApp.cusBlue, size: 40),
              icon: Icon(Icons.home, size: 40),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart, size: 40),
              selectedIcon: Icon(
                Icons.shopping_cart,
                color: ColorApp.cusBlue,
                size: 40,
              ),
              label: "Cart",
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite, size: 40),
              selectedIcon: Icon(
                Icons.favorite,
                color: ColorApp.cusBlue,
                size: 40,
              ),
              label: "Wishlist",
            ),
            NavigationDestination(
              icon: Icon(Icons.person, size: 40),
              selectedIcon: Icon(
                Icons.person,
                color: ColorApp.cusBlue,
                size: 40,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
