import 'package:chicly_store/core/routes/app_routes.dart';
import 'package:chicly_store/core/constant/local_storage_service.dart';
import 'package:chicly_store/features/auth/presentation/auth/widgets/logo_store.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
    Future<void> _checkIfLoggedIn() async {
      final  isLoggedIn = await LocalStorageService.isUserLoggedIn();
      if (isLoggedIn) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        }
      }
      else {

          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }

    }

  @override
  void initState() {
    // TODO: implement initState
      Future.delayed(const Duration(seconds: 3), () {
    _checkIfLoggedIn();
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Lottie.asset(
            "assets/animation/Stars.json",
            width: double.infinity,
            height: double.infinity,
          ),
          Center(child: LogoStore(color: Colors.white)),
        ],
      ),
    );
  }
}
