import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:goldyu/features/authentication/controllers/user.controller.dart';
import 'package:goldyu/features/shope/screens/home/widgets/home_appbar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final UserController userController = Get.put(UserController());

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
                  Obx(() => _buildEditableField(
                        label: "Name",
                        controller: userController.nameController,
                        isEditable: userController.isNameEditable.value,
                        onDoubleTap: () {
                          userController.toggleNameEditable();
                        },
                      )),

                  const SizedBox(height: 16),

                  // Email Field
                  Obx(() => _buildEditableField(
                        label: "Email",
                        controller: userController.emailController,
                        isEditable: userController.isEmailEditable.value,
                        onDoubleTap: () {
                          userController.toggleEmailEditable();
                        },
                      )),

                  const SizedBox(height: 16),

                  // Phone Number Field
                  Obx(() => _buildEditableField(
                        label: "Phone Number",
                        controller: userController.phoneController,
                        isEditable: userController.isPhoneEditable.value,
                        onDoubleTap: () {
                          userController.togglePhoneEditable();
                        },
                      )),

                  const SizedBox(height: 16),

                  // Password Field
                  Obx(() => _buildEditableField(
                        label: "Password",
                        controller: userController.passwordController,
                        isEditable: userController.isPasswordEditable.value,
                        onDoubleTap: () {
                          userController.togglePasswordEditable();
                        },
                        isObscured: true, // Hide password by default
                      )),

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
    required bool isEditable,
    required VoidCallback onDoubleTap,
    bool isObscured = false,
  }) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: TextField(
        controller: controller,
        enabled: isEditable,
        obscureText: isObscured,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: isEditable ? Colors.white : Colors.grey.shade200,
        ),
        style: TextStyle(
          color: isEditable ? Colors.black : Colors.grey.shade600,
        ),
      ),
    );
  }
}
