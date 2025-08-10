import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider with ChangeNotifier {

  OnboardingProvider(){
    loadOnboardingStatus();
  }

  bool _onboardingSeen = false;

  bool get onboardingSeen => _onboardingSeen;

  Future<void> loadOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _onboardingSeen = prefs.getBool('onboarding_seen') ?? false;
    notifyListeners();
  }

  Future<void> setOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
    _onboardingSeen = true;
    notifyListeners();
  }
}
