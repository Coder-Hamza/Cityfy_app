import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:cityguide_app/core/common/custom_button.dart';
import 'package:cityguide_app/core/common/custom_textfield.dart';
import 'package:cityguide_app/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formkey = GlobalKey<FormState>();
  AuthService _authService = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  final _nameFocus = FocusNode();
  final _phonenumberFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    phonenumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    _nameFocus.dispose();
    _phonenumberFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                50.verticalSpace,
                Image.asset("assets/images/signup.png"),
                35.verticalSpace,
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                20.verticalSpace,
                CustomTextField(
                  textfieldcontroller: nameController,
                  hintText: "Full Name",
                  focusNode: _nameFocus,
                  prefixIcon: Icon(Icons.person_2_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your full name";
                    }
                    return null;
                  },
                ),
                20.verticalSpace,
                CustomTextField(
                  textfieldcontroller: phonenumberController,
                  hintText: "Phone Number",
                  focusNode: _phonenumberFocus,
                  prefixIcon: Icon(Icons.call),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone number";
                    }
                    final phoneRegex = RegExp(r'^(?:\+92|0)3[0-9]{9}$');
                    if (!phoneRegex.hasMatch(value)) {
                      return "Please enter a valid phone number {e.g. , +12345678}";
                    }
                    return null;
                  },
                ),
                20.verticalSpace,
                CustomTextField(
                  textfieldcontroller: emailController,
                  hintText: "Email",
                  focusNode: _emailFocus,
                  prefixIcon: Icon(Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email address";
                    }
                    final emailRegex = RegExp(
                      r'^[\w\.-]+@([\w-]+\.)+[\w]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value)) {
                      return "Please enter a valid email address (e.g., example@email.com)";
                    }
                    return null;
                  },
                ),
                20.verticalSpace,
                CustomTextField(
                  textfieldcontroller: passwordController,
                  hintText: "Password",
                  focusNode: _passwordFocus,
                  obscureText: _isPasswordVisible,
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 digits long";
                    }
                    return null;
                  },
                ),
                20.verticalSpace,
                CustomButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _authService.CreateAccount(
                        nameController.text,
                        emailController.text,
                        phonenumberController.text,
                        passwordController.text,
                        context,
                      );
                      // Hide Keyboard
                      FocusScope.of(context).unfocus();
                      // Clear Fields
                      nameController.clear();
                      phonenumberController.clear();
                      emailController.clear();
                      passwordController.clear();
                      print("Registerd Successfully");
                    }
                  },
                  text: "Registration",
                ),
                20.verticalSpace,
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Appcolors.black, fontSize: 15),
                      children: [
                        TextSpan(
                          text: " SignIn",
                          style: TextStyle(
                            color: Appcolors.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/signin');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
