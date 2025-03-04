import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/core/helpers/secure_storage_helper.dart';
import 'package:goldyu/data/providers/api_service.dart';
import 'package:goldyu/features/shope/screens/home/home.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;

  // controllers foe Email and Password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    isLoading.value = true;
    try {
      final response = await THttpClient.post('/login', data: {
        'email': emailController.text,
        'password': passwordController.text,
      });
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String token = data['token'];
        // Save token
        await SecureStorageHelper.saveToken(token);

        Get.offAll(() => HomeScreen());
      } else {
        if (data['message']['errors']['email'] != null) {
          Get.snackbar('Error', data['message']['errors']['email'], snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar('Error', data['message'], snackPosition: SnackPosition.BOTTOM);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Try again.', snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.value = false;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
