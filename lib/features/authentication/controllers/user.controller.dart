import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/models/user.dart';
import 'package:goldyu/data/repositories/user.api.dart';

class UserController extends GetxController {
  var user = Rx<User?>(null); // Stores the logged-in user

  // Existing method
  void setUser(User newUser) {
    user.value = newUser;
    nameController.text = newUser.name;
    emailController.text = newUser.email;
    phoneController.text = newUser.phone;
  }

  // New fields for profile editing
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  var isNameEditable = false.obs;
  var isEmailEditable = false.obs;
  var isPhoneEditable = false.obs;
  var isPasswordEditable = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (user.value != null) {
      // Initialize controllers with user data
      nameController.text = user.value!.name;
      emailController.text = user.value!.email;
      phoneController.text = user.value!.phone;
    }
  }

  // Toggle editability for each field
  void toggleNameEditable() {
    isNameEditable.value = !isNameEditable.value;
  }

  void toggleEmailEditable() {
    isEmailEditable.value = !isEmailEditable.value;
  }

  void togglePhoneEditable() {
    isPhoneEditable.value = !isPhoneEditable.value;
  }

  void togglePasswordEditable() {
    isPasswordEditable.value = !isPasswordEditable.value;
  }

  // Update user info
  Future<void> updateUserInfo() async {
    try {
      // Prepare data for the update
      final updatedData = {
        'id': user.value!.id,
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passwordController.text.isNotEmpty ? passwordController.text : null, // Only send password if it's not empty
      };

      // Call the API to update user info
      final response = await UserApi.updateUser(updatedData['id'] as int, updatedData as User);

      if (response!.id != null) {
        // Update the local user object
        user.value = User(
          id: user.value!.id,
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
        );

        Get.snackbar("Success", "User info updated successfully!");
      } else {
        Get.snackbar("Error", "Failed to update user info.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}
