import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:flutter/material.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cities Pages"),
        backgroundColor: Colors.green,
      ),
    );
  }
}
