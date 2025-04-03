import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/features/shope/controllers/employee/employee.controller.dart';
import 'package:goldyu/features/shope/screens/employees/widgets/emplyee_card.dart';

class EmployeeList extends StatelessWidget {
  EmployeeList({super.key});

  final EmployeeController employeeController = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (employeeController.isLoading.value && employeeController.employees.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      if (employeeController.errorMessage.value.isNotEmpty) {
        return Center(child: Text(employeeController.errorMessage.value, style: const TextStyle(color: Colors.red)));
      }
      return SizedBox(
        height: 400,
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: employeeController.employees.length,
            itemBuilder: (context, index) {
              final employee = employeeController.employees[index];
              return EmployeeCard(employee: employee);
            },
          ),
        ),
      );
    });
  }
}
