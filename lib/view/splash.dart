import 'package:firebase_gemini_ai/controller/splash_controller.dart';
import 'package:firebase_gemini_ai/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashController = SplashController();
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        splashController.verifyUser(context);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBgColor,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(
            5.0,
          ),
          child: Lottie.asset(
            'assets/lottie/loading.json',
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }
}
