import 'package:chicly_store/features/home/screen/home_body.dart';
import 'package:chicly_store/features/home/widgets/best_sale_product.dart';
import 'package:chicly_store/features/home/widgets/product_card_shimmer.dart';
import 'package:chicly_store/features/home/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoadingScreen extends StatelessWidget {
  const HomeLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold  (
      body: SafeArea(
          child: Column(
            spacing: 20,
            children: [
              CustomSearchBar(),
          
              Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              BestSaleProduct(),
          
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (BuildContext context, int index) =>
                      ProductCardShimmer(),
                  itemCount: 10,
                ),
              ),
            ],
          ),
      ),
    );
  }
}
