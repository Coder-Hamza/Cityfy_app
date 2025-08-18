import 'package:cityguide_app/app.dart';
import 'package:cityguide_app/firebase_options.dart';
import 'package:cityguide_app/notifier/onbording_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://ztivcsqrwzzdiawqgheq.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp0aXZjc3Fyd3p6ZGlhd3FnaGVxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUzMzUzNDksImV4cCI6MjA3MDkxMTM0OX0.dWP7J6-8xiIEBCu_TQE7Iu8E7f6idTWoktbSqdT11EI",
  );
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
