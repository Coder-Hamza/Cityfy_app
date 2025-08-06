import 'package:cityguide_app/core/common/custom_button.dart';
import 'package:cityguide_app/core/common/custom_textfield.dart';
import 'package:cityguide_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void dispose() {
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Image.asset("assets/images/forget.png", height: 250),
              40.verticalSpace,
              Text(
                "Reset Password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              15.verticalSpace,
              Text(
                "Enter the email address \n asscociated with your account",
                textAlign: TextAlign.center,
              ),
              Form(
                key: _formkey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      40.verticalSpace,
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
                      CustomButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _authService.ForgetPassword(
                              emailController.text,
                              context,
                            );
                            // Just for admin login
                            // Hide Keyboard
                            FocusScope.of(context).unfocus();
                            // Clear Fields
                            emailController.clear();
                          }
                        },
                        text: "Send Email",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
