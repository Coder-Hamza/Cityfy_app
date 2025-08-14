import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Create Account Method

  CreateAccount(
    String name,
    email,
    phonenumber,
    password,
    BuildContext context,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushNamed(context, '/signin');
    } catch (e) {
      print(e);
    }
  }

  // Sign In Method

  SignIn(String email, password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamedAndRemoveUntil(context, '/navigate', (route) => false);
    } catch (e) {
      print(e);
    }
  }

  LogOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);
  }

  // Forget Password Method

  ForgetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Navigator.pushReplacementNamed(context, '/signin');
    } catch (e) {
      print(e);
    }
  }
}
