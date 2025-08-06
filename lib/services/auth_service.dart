import 'package:cityguide_app/screens/home.dart';
import 'package:cityguide_app/screens/signin.dart';
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

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Signin()),
      );
    } catch (e) {
      print(e);
    }
  }

  // Sign In Method

  SignIn(String email, password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        (route) => false,
      );
    } catch (e) {
      print(e);
    }
  }

  // Forget Password Method

  ForgetPassword(String email, BuildContext context) async {
    try {
      _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }
}
