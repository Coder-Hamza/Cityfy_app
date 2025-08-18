import 'dart:io';
import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  File? _imageFile;
  bool _isLoading = false;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      final data = snapshot.data();
      if (data != null) {
        _nameController.text = data['name'] ?? '';
        _emailController.text = data['email'] ?? '';
        _phoneController.text = data['phone'] ?? '';
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadToSupabase(File file) async {
    try {
      final fileName =
          "${user!.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg";
      final response = await Supabase.instance.client.storage
          .from('profile_pics')
          .upload(fileName, file);

      final publicUrl = Supabase.instance.client.storage
          .from('profile_pics')
          .getPublicUrl(fileName);

      return publicUrl;
    } catch (e) {
      print("Upload Error: $e");
      throw Exception("Image upload failed");
    }
  }

  Future<String?> _askCurrentPassword() async {
    final controller = TextEditingController();
    String? result;

    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Re-authentication Required"),
          content: TextField(
            controller: controller,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Enter Current Password",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                result = controller.text;
                Navigator.pop(ctx);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );

    return result;
  }

  Future<void> _updateProfile() async {
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      String? imageUrl;

      // upload new image
      if (_imageFile != null) {
        imageUrl = await _uploadToSupabase(_imageFile!);
      }

      // re-authenticate if email or password is being changed
      if (_emailController.text != user!.email ||
          _passwordController.text.isNotEmpty) {
        final currentPassword = await _askCurrentPassword();

        if (currentPassword == null || currentPassword.isEmpty) {
          throw Exception("Current password required to update email/password");
        }

        final cred = EmailAuthProvider.credential(
          email: user!.email!,
          password: currentPassword,
        );

        await user!.reauthenticateWithCredential(cred);

        if (_emailController.text.isNotEmpty &&
            _emailController.text != user!.email) {
          await user!.updateEmail(_emailController.text.trim());
        }

        if (_passwordController.text.isNotEmpty) {
          await user!.updatePassword(_passwordController.text.trim());
        }
      }

      // update firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
            'name': _nameController.text,
            'email': _emailController.text,
            'phone': _phoneController.text,
            if (imageUrl != null) 'profileImage': imageUrl,
          });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile updated successfully"),
          backgroundColor: Appcolors.primaryColor,
        ),
      );
    } catch (e) {
      print("Update Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Update failed: $e")));
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(fontSize: 22)),
        backgroundColor: Appcolors.primaryColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : null,
                      child: _imageFile == null
                          ? const Icon(Icons.camera_alt, size: 40)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: "Phone",
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "New Password",
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        // First, call your update function
                        await _updateProfile();

                        // Then navigate and remove all previous routes
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/profile',
                          (routes) => false,
                        );
                      },
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
