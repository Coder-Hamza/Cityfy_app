import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:cityguide_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Appcolors.primaryColor,
        title: const Text("My Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: _authService.getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              final userData = snapshot.data ?? {};
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Profile Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Appcolors.primaryColor.withOpacity(0.8),
                            Appcolors.primaryColor.withOpacity(0.6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Appcolors.primaryColor.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            backgroundImage: userData["profileImage"] != null
                                ? NetworkImage(userData["profileImage"])
                                : null,
                            child: userData["profileImage"] == null
                                ? const Icon(
                                    Icons.person,
                                    size: 45,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                          15.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData["name"] ?? "No Name",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                5.verticalSpace,
                                Text(
                                  userData["email"] ?? "No Email",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    25.verticalSpace,

                    // Options List
                    buildOptionCard(
                      icon: Icons.edit,
                      text: "Edit Profile",
                      onTap: () {
                        Navigator.pushNamed(context, '/profileedit');
                      },
                    ),
                    buildOptionCard(
                      icon: Icons.language,
                      text: "Language",
                      onTap: () {
                        Navigator.pushNamed(context, '/language');
                      },
                    ),
                    buildOptionCard(
                      icon: Icons.error_outline_outlined,
                      text: "Terms & Conditions",
                      onTap: () {
                        Navigator.pushNamed(context, '/termsconditon');
                      },
                    ),
                    buildOptionCard(
                      icon: Icons.logout,
                      text: "Sign Out",
                      onTap: () {
                        _authService.LogOut(context);
                      },
                    ),
                    buildOptionCard(
                      icon: Icons.delete_forever,
                      text: "Delete Account",
                      onTap: () {
                        _showDeleteAccountDialog();
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildOptionCard({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Appcolors.primaryColor.withOpacity(0.15),
          child: Icon(icon, color: Appcolors.primaryColor),
        ),
        title: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  // -----------------------
  // Delete Account Function
  // -----------------------
  void _showDeleteAccountDialog() {
    final _passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete Account"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Please enter your password to delete your account."),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolors.primaryColor,
            ),
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              final password = _passwordController.text.trim();

              if (user != null && password.isNotEmpty) {
                try {
                  // Re-authenticate
                  final credential = EmailAuthProvider.credential(
                    email: user.email!,
                    password: password,
                  );
                  await user.reauthenticateWithCredential(credential);

                  // Delete user
                  await user.delete();

                  // Optional: Firestore document delete
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .delete();

                  Navigator.pop(context); // Close dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Account deleted successfully"),
                      backgroundColor: Colors.red,
                    ),
                  );

                  // Navigate back or logout
                  Navigator.pushReplacementNamed(context, '/login');
                } catch (e) {
                  Navigator.pop(context); // Close dialog
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Delete Error: $e")));
                }
              }
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
