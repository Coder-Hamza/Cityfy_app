import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events Pages"),
        backgroundColor: Appcolors.primaryColor,
      ),
    );
  }
}
