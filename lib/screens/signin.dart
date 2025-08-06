import 'package:cityguide_app/admin/admin.dart';
import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:cityguide_app/core/common/custom_button.dart';
import 'package:cityguide_app/core/common/custom_textfield.dart';
import 'package:cityguide_app/screens/forgetpassword.dart';
import 'package:cityguide_app/screens/home.dart';
import 'package:cityguide_app/screens/signup.dart';
import 'package:cityguide_app/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                Image.asset("assets/images/signin.png"),
                35.verticalSpace,
                Text(
                  "Sign In",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                      _authService.SignIn(
                        emailController.text,
                        passwordController.text,
                        context,
                      );
                      // Just for admin login
                      if (emailController.text == "admincityguide@gmail.com" &&
                          passwordController.text == "admin123") {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Admin()),
                          (Route) => false,
                        );
                      }
                      // Hide Keyboard
                      FocusScope.of(context).unfocus();
                      // Clear Fields
                      emailController.clear();
                      passwordController.clear();
                      print("Login");
                    }
                  },
                  text: "Sign In",
                ),
                30.verticalSpace,
                RichText(
                  text: TextSpan(
                    text: "Forget Password?",
                    style: TextStyle(color: Appcolors.black, fontSize: 15),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Forgetpassword(),
                          ),
                        );
                      },
                  ),
                ),
                20.verticalSpace,
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Appcolors.black, fontSize: 15),
                      children: [
                        TextSpan(
                          text: " SignUp",
                          style: TextStyle(
                            color: Appcolors.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signup(),
                                ),
                              );
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
