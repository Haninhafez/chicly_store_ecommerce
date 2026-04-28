import 'package:chicly_store/core/utils/full_width_card_product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingBody extends StatelessWidget {
  const ShimmerLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        body: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: FullWidthCardProductShimmer(),
          ),
        ),
      
    );
  }
}
