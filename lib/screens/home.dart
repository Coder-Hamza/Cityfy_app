import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:cityguide_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        backgroundColor: Appcolors.primaryColor,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    _authService.LogOut(context);
                  },
                  child: Text("Sign Out"),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
