import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/models/user.dart';
import 'package:goldyu/data/providers/api_service.dart';

class EmployeeController extends GetxController {
  var employees = <User>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await THttpClient.get('/employees');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        employees.value = (data['employees'] as List).map((employee) => User.fromJson(employee)).toList();
      } else {
        final data = jsonDecode(response.body);
        errorMessage.value = data['message'] ?? 'Failed to fetch employees';
        Get.snackbar("Error", errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  // Create Employee
  Future<void> createEmployee() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await THttpClient.post('/create-employee', data: {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': passwordConfirmationController.text,
        'phone': phoneController.text,
      });

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        employees.add(User.fromJson(data['user']));
        Get.snackbar("Success", "Employee created successfully");
        clearFormFields();
      } else {
        final data = jsonDecode(response.body);
        errorMessage.value = data['message'] ?? 'Failed to create employee';
        Get.snackbar("Error", errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  // Update Employee
  Future<void> updateEmployee(int employeeId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await THttpClient.put('/user/update/$employeeId', data: {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        if (passwordController.text.isNotEmpty) ...{
          'password': passwordController.text,
          'password_confirmation': passwordConfirmationController.text,
        },
      });

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Employee updated successfully");
        clearFormFields();
        // Fetch the latest list of employees
        await fetchEmployees();
      } else {
        final data = jsonDecode(response.body);
        errorMessage.value = data['message'] ?? 'Failed to update employee';
        Get.snackbar("Error", errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  // Get User (Employee or Admin)
  Future<void> getUser(int userId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await THttpClient.get('/user/$userId');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user']);
        // You can use this user data as needed
        Get.snackbar("Success", "User fetched successfully");
      } else {
        final data = jsonDecode(response.body);
        errorMessage.value = data['message'] ?? 'Failed to fetch user';
        Get.snackbar("Error", errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  // Clear form fields
  void clearFormFields() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    passwordConfirmationController.clear();
  }
}
