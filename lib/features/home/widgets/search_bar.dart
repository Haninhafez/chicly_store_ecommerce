import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                gapPadding: 1,
              ),
              hintText: "Search",
              
              prefixIcon: const Icon(Icons.search, size: 20),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.products);
          },
          icon: const Icon(
            Icons.shopping_basket_rounded,
            size: 25,
            color: Color.fromARGB(255, 83, 83, 83),
          ),
        ),
      ],
    );
  }
}
