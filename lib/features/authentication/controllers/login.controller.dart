import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/models/user.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/core/helpers/secure_storage_helper.dart';
import 'package:goldyu/data/repositories/user.api.dart';
import 'package:goldyu/features/authentication/screens/login/login.dart';
import 'package:goldyu/features/shope/screens/home/home.dart';
import 'package:iconsax/iconsax.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  final rememberMe = false.obs;
  final Rxn<User> user = Rxn<User>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    isLoading.value = true;
    try {
      final authResponse = await UserApi.login(
        emailController.text,
        passwordController.text,
        rememberMe.value,
      ).timeout(const Duration(seconds: 5));

      if (authResponse != null) {
        user.value = authResponse.user; // Set user data
        await SecureStorageHelper.saveToken(authResponse.token); // Store token

        // Navigate to HomeScreen with user data
        Get.offAll(() => HomeScreen(data: authResponse.user));
      } else {
        showErrorSnackbar('Invalid credentials. Try again.');
      }
    } catch (e) {
      showErrorSnackbar('Something went wrong. Try again.');
    }
    isLoading.value = false;
  }

  Future<void> logout() async {
    String? token = await SecureStorageHelper.getToken();
    if (token != null) {
      await UserApi.logout();
      await SecureStorageHelper.deleteToken();
      Get.offAll(() => LoginScreen());
    }
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: Icon(Iconsax.info_circle, color: TColors.white),
    );
  }

  Future<void> checkToken() async {
    // Retrieve the token from secure storage
    String? token = await SecureStorageHelper.getToken();

    if (token != null) {
      // Validate the token with the backend (this depends on your API)
      final userRes = await UserApi.validateToken(token);

      if (userRes != null) {
        user.value = userRes; // Set user data
        Get.offAll(() => HomeScreen(data: user.value)); // Navigate to home
      } else {
        await SecureStorageHelper.deleteToken();
        Get.offAll(() => LoginScreen());
      }
    } else {
      // No token, navigate to login
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }
}
