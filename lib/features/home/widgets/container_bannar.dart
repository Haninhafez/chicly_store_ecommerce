import 'package:chicly_store/core/constant/custom_text_style.dart';
import 'package:flutter/material.dart';

class ContainerBanar extends StatelessWidget {
  const ContainerBanar({super.key, required this.iamgePath});
  final String iamgePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(iamgePath),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(20),
          ),

          width: double.infinity,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(2),
          alignment: Alignment.bottomLeft,
        ),
      ],
    );
  }
}
