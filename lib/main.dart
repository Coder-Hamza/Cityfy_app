import 'package:cityguide_app/app.dart';
import 'package:cityguide_app/firebase_options.dart';
import 'package:cityguide_app/notifier/onbording_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnboardingProvider()),
      ],
      child: MyApp(),
    ),
  );
}
