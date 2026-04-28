import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:chicly_store/core/constant/color_app.dart';

class FullWidthCardProductShimmer extends StatelessWidget {
  const FullWidthCardProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image Placeholder
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(width: 10),

            /// Text Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8),

                  Container(height: 16, width: 150, color: Colors.grey),

                  const SizedBox(height: 10),

                  /// Rating
                  Row(
                    children: [
                      Container(height: 14, width: 60, color: Colors.grey),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Price + Button
                  Row(
                    children: [
                      Container(height: 18, width: 80, color: Colors.grey),
                      const Spacer(),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
