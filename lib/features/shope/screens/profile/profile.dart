import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:goldyu/features/authentication/controllers/user.controller.dart';
import 'package:goldyu/features/shope/screens/home/widgets/home_appbar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HomeAppBar
            PrimaryHeaderContainer(
              height: 200,
              child: Column(
                children: [
                  HomeAppBar(),
                ],
              ),
            ),

            // Profile Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Name Field
                  _buildEditableField(
                    label: "Name",
                    controller: userController.nameController,
                  ),

                  const SizedBox(height: 16),

                  // Email Field
                  _buildEditableField(
                    label: "Email",
                    controller: userController.emailController,
                  ),

                  const SizedBox(height: 16),

                  // Phone Number Field
                  _buildEditableField(
                    label: "Phone Number",
                    controller: userController.phoneController,
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  _buildEditableField(
                    label: "Password",
                    controller: userController.passwordController,
                    isObscured: true, // Hide password by default
                  ),

                  const SizedBox(height: 32),

                  // Update Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await userController.updateUserInfo();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Update",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    bool isObscured = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscured,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
