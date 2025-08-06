import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users Pages"),
        backgroundColor: Appcolors.primaryColor,
      ),
    );
  }
}
