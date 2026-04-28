import 'package:flutter/material.dart';

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 10,
      color: const Color.fromARGB(123, 158, 158, 158),
      thickness: 1,
      endIndent: 50,
      indent: 50,
    );
  }
}
