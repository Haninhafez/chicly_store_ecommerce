import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:flutter/material.dart';

class BuildImageProduct extends StatefulWidget {
  const BuildImageProduct({super.key, required this.product});
  final ProductModel product;

  @override
  State<BuildImageProduct> createState() => _BuildImageProductState();
}

class _BuildImageProductState extends State<BuildImageProduct> {
  late PageController _pageController;
  int _selectedImageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: _selectedImageIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: PageView.builder(
            controller: _pageController, // ✅ استخدام الـ Controller
            onPageChanged: (int index) {
              setState(() {
                _selectedImageIndex = index;
              });
            },
            itemCount: widget.product.images.length,
            itemBuilder: (context, index) {
              return Hero(
                transitionOnUserGestures: true,
                tag: 'product_${widget.product.id}_$index',
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 2.0,
                  child: Image.network(
                    widget.product.images[index].url,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),

        if (widget.product.images.length > 1)
          Align(
            alignment: AlignmentGeometry.center,
            child: Container(
              height: 80,

              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(widget.product.images.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 70,
                        height: 70,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _selectedImageIndex == index
                                ? ColorApp.cusBlue
                                : Colors.grey[300]!,
                            width: _selectedImageIndex == index ? 3 : 1,
                          ),
                          boxShadow: _selectedImageIndex == index
                              ? [
                                  BoxShadow(
                                    color: ColorApp.primayLight.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.product.images[index].url,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.image,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
