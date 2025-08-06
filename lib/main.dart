import 'package:cityguide_app/admin/admin.dart';
import 'package:cityguide_app/admin/users.dart';
import 'package:cityguide_app/admin/cities.dart';
import 'package:cityguide_app/admin/events.dart';
import 'package:cityguide_app/admin/reviews.dart';
import 'package:cityguide_app/firebase_options.dart';
import 'package:cityguide_app/screens/home.dart';
import 'package:cityguide_app/screens/logo_screen.dart';
import 'package:cityguide_app/screens/signin.dart';
import 'package:cityguide_app/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          home: steam,
          routes: {
            '/admin': (context) => Admin(),
            '/home': (context) => Home(),
            '/signup': (context) => Signup(),
            '/signin': (context) => Signin(),
            '/citiesPage': (context) => CitiesPage(),
            '/eventsPage': (context) => EventsPage(),
            '/reviewsPage': (context) => ReviewsPage(),
            '/usersPage': (context) => UsersPage(),
          },
        );
      },
    );
  }
}
