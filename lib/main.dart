import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/app.dart';
import 'package:goldyu/features/authentication/controllers/user.controller.dart';

void main() {
  Get.put(UserController()); // Ensure UserController is initialized
  runApp(const App());
}
