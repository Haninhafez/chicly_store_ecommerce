   import 'package:flutter/material.dart';

Widget custom_row(List<Widget> children) {
    return Row(
      children: children
          .map(
            (w) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: w,
              ),
            ),
          )
          .toList(),
    );
  }
