import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // For Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // For Database
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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

      // Save User Data In Firestore

      _db.collection("users").doc(_auth.currentUser!.uid).set({
        "id": _auth.currentUser!.uid,
        "name": name,
        "email": email,
      });

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

  // Get Current User Details

  Future getUserDetails() async {
    try {
      var userDoc = await _db
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .get();

      return userDoc.data();
    } on FirebaseException catch (e) {
      throw e.message ?? "Something Went Wrong";
    }
  }

  // Edit Profile

  // ✅ Reauthenticate user before sensitive changes
  Future<void> reauthenticateUser(String email, String password) async {
    final user = _auth.currentUser;

    if (user != null) {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);
    }
  }

  // ✅ Update email
  Future<void> updateEmail(String newEmail) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updateEmail(newEmail);
    }
  }

  // ✅ Update password
  Future<void> updatePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
      
    }
  }


  // ✅ Save user profile
  Future<void> saveUserProfile({
    required String name,
    required String phone,
    required String profileImage,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _db.collection('users').doc(uid).set({
      'id': uid,
      'name': name,
      'phone': phone,
      'email': FirebaseAuth.instance.currentUser!.email,
      'profileImage': profileImage,
    }, SetOptions(merge: true));
  }

  // ✅ Get user profile
  Future<Map<String, dynamic>?> getUserProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await _db.collection('users').doc(uid).get();

    if (doc.exists) {
      return doc.data();
    }
    return null;
  }
}


