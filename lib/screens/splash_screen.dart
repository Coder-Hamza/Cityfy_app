import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:cityguide_app/notifier/onbording_notifier.dart';
import 'package:cityguide_app/screens/auth_gate.dart';
import 'package:cityguide_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadInitial();
    super.initState();
  }

  void loadInitial() async {
    final onboardingProvider = Provider.of<OnboardingProvider>(
      context,
      listen: false,
    );

    await onboardingProvider.loadOnboardingStatus();
    await Future.delayed(Duration(seconds: 3)); // simulate splash

    if (onboardingProvider.onboardingSeen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AuthGate()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.white,
      // backgroundColor: Appcolors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/images/splash.json"),
          Text(
            "CityFy App",
            style: TextStyle(
              fontSize: 40,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Appcolors.primaryColor,
            ),
          ),
          200.verticalSpace,
          Text(
            "Smart Guide To All City",
            style: TextStyle(
              fontSize: 22,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Appcolors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
