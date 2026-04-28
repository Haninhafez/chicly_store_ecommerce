import 'package:chicly_store/features/auth/presentation/auth/service/firebase_auth_service.dart';
import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            signInWithFacebook(context);
          },
          icon: Icon(Icons.facebook, color: Colors.blue, size: 40),
        ),

        IconButton(
          onPressed: () {},
          icon: Icon(Icons.apple, color: Colors.black, size: 42),
        ),

        IconButton(
          onPressed: () {
            signInWithGoogle(context);
          },
          icon: FaIcon(FontAwesomeIcons.google, color: Colors.red, size: 35),
        ),
      ],
    );
  }
}
