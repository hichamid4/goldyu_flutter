import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/models/user.dart';
import 'package:goldyu/core/helpers/secure_storage_helper.dart';
import 'package:goldyu/data/providers/api_service.dart';
import 'dart:convert';

import 'package:goldyu/features/shope/screens/home/home.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  var isLoading = false.obs;
  final Rxn<User> user = Rxn<User>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isPasswordHidden2 = true.obs;

  Future<void> signup() async {
    isLoading.value = true;
    showLoadingOverlay(); // Show spinner overlay

    try {
      final response = await THttpClient.post('/register', data: {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': passwordConfirmationController.text,
        'phone': phoneController.text,
      }).timeout(const Duration(seconds: 5));

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        String token = data['token'];
        await SecureStorageHelper.saveToken(token);

        user.value = User.fromJson(data['user']);

        // Show success message
        showSuccessOverlay();

        await Future.delayed(const Duration(seconds: 2)); // Wait before redirecting

        Get.offAll(() => HomeScreen(data: data['user'])); // Navigate to home
      } else {
        print('Signup Failed: ${data['message']}');
        Get.back(); // Remove overlay
        Get.snackbar(
          'Error',
          data['message'] ?? 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Signup Error: $e');
      Get.back(); // Remove overlay
      Get.snackbar(
        'Error',
        'Something went wrong. Try again',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    isLoading.value = false;
  }

  void showLoadingOverlay() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  void showSuccessOverlay() {
    Get.dialog(
      Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 50),
              SizedBox(height: 10),
              Text("Welcome!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }
}
