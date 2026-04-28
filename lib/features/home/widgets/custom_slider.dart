import 'package:carousel_slider/carousel_slider.dart';
import 'package:chicly_store/features/home/widgets/container_bannar.dart';
import 'package:flutter/material.dart';

class CustomSliderBanner extends StatelessWidget {
  const CustomSliderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        ContainerBanar(iamgePath: "assets/images/bannar1.jpg"),
        ContainerBanar(iamgePath: "assets/images/bannar2.jpg"),
        ContainerBanar(iamgePath: "assets/images/bannar3.jpg"),
      ],
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.20,
        autoPlay: true,
        autoPlayCurve: Curves.decelerate,
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        enableInfiniteScroll: true,
        viewportFraction: .95,
      
      ),
    );
  }
}
