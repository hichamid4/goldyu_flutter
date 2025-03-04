import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;

  // controllers foe Email and Password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}
