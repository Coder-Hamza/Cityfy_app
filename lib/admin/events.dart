import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events & Attractions"),
        backgroundColor: Appcolors.primaryColor,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/eventsaddPage');
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Events \n & Attractions'),
        backgroundColor: Appcolors.primaryColor,
        foregroundColor: Appcolors.white,
      ),
    );
  }
}
