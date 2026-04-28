import 'package:flutter/material.dart';

class BadgeInCheckout extends StatelessWidget {
  const BadgeInCheckout({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, color: Colors.grey, height: 1.3),
        ),
      ],
    );
  }
}
