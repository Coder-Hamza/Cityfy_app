import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolors.primaryColor,
        title: Text("Favorite"),
      ),
    );
  }
}
