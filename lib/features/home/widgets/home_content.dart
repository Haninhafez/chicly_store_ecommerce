
import 'package:chicly_store/features/home/widgets/best_sale_product.dart';
import 'package:chicly_store/features/home/widgets/custom_slider.dart';
import 'package:chicly_store/core/utils/product_grid_card.dart';
import 'package:chicly_store/features/home/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key, this.state});
  final dynamic state;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  spacing: 20,
                  children: [
                    CustomSearchBar(),

                    const CustomSliderBanner(),

                    BestSaleProduct(),

                    const SizedBox(height: 10),
                  ],
                ),
              ),

              SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (BuildContext context, int index) =>
                    ProductGridCard(productModel: state.products[index]),
                itemCount: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
