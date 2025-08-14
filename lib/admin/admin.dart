import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:cityguide_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Admin extends StatelessWidget {
  final AuthService _authService = AuthService();

  final List<Map<String, dynamic>> components = const [
    {
      'title': 'Add Cities',
      'icon': Icons.location_city,
      'route': '/citiesPage',
    },
    {
      'title': 'Add Events & \n  Attractions ',
      'icon': Icons.event,
      'route': '/eventsPage',
    },
    {'title': 'View Users', 'icon': Icons.person_search, 'route': '/usersPage'},
    {'title': 'View Review', 'icon': Icons.reviews, 'route': '/reviewsPage'},
  ];

  Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "WELCOME ADMIN",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Appcolors.primaryColor,
              ),
            ),
            const Text(
              "Vin Diesel",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          // Profile Image
          Padding(
            padding: EdgeInsets.only(right: 10.w, top: 5.h),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/images/admin.png"),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Appcolors.primaryColor),
            tooltip: "Sign Out",
            onPressed: () {
              _authService.LogOut(context);
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: components.length,
          itemBuilder: (context, index) {
            final item = components[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, item['route']);
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 28),
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  height: 110,
                  decoration: BoxDecoration(
                    color: Appcolors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(item['icon'], size: 35, color: Colors.white),
                              const SizedBox(width: 16),
                              Flexible(
                                child: Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
