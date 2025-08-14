import 'package:cityguide_app/admin/admin.dart';
import 'package:cityguide_app/admin/users.dart';
import 'package:cityguide_app/admin/cities.dart';
import 'package:cityguide_app/admin/events.dart';
import 'package:cityguide_app/admin/reviews.dart';
import 'package:cityguide_app/core/bottom_navbar.dart';
import 'package:cityguide_app/screens/auth_gate.dart';
import 'package:cityguide_app/screens/favorite.dart';
import 'package:cityguide_app/screens/forgetpassword.dart';
import 'package:cityguide_app/screens/home.dart';
import 'package:cityguide_app/screens/logo_screen.dart';
import 'package:cityguide_app/screens/onboarding_screen.dart';
import 'package:cityguide_app/screens/profile.dart';
import 'package:cityguide_app/screens/search.dart';
import 'package:cityguide_app/screens/signin.dart';
import 'package:cityguide_app/screens/signup.dart';
import 'package:cityguide_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        375,
        812,
      ), // Design size from Figma (width, height)
      minTextAdapt: true, // Auto adjust text sizes
      splitScreenMode: true, // For tablet support
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CityFy App',
          theme: ThemeData(fontFamily: 'Poppins'),
          home: LogoScreen(),
          routes: {
            // Admin Pages
            '/admin': (context) => Admin(),
            '/citiesPage': (context) => const CitiesPage(),
            '/eventsPage': (context) => const EventsPage(),
            '/reviewsPage': (context) => const ReviewsPage(),
            '/usersPage': (context) => const UsersPage(),

            // User Pages
            '/logo': (context) => const LogoScreen(),
            '/splash': (context) => const SplashScreen(),
            '/onboarding': (context) => const OnboardingScreen(),
            '/authgate': (context) => const AuthGate(),
            '/signup': (context) => const Signup(),
            '/signin': (context) => const Signin(),
            '/forgetpassword': (context) => const Forgetpassword(),
            '/navigate': (context) => const BottomNavBar(),
            '/home': (context) => const Home(),
            '/favorite': (context) => const Favorite(),
            '/search': (context) => const Search(),
            '/profile': (context) => const Profile(),
          },
        );
      },
    );
  }
}
