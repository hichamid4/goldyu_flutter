import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/widgets/Texts/section_heading.dart';
import 'package:goldyu/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/features/shope/controllers/employee/employee.controller.dart';
import 'package:goldyu/features/shope/screens/employees/widgets/employees_list.dart';
import 'package:goldyu/features/shope/screens/employees/widgets/emplyee_card.dart';
import 'package:goldyu/features/shope/screens/home/widgets/home_appbar.dart';
import 'package:goldyu/features/shope/screens/home/widgets/home_categories.dart';
import 'package:iconsax/iconsax.dart';

class EmployeesScreen extends StatelessWidget {
  EmployeesScreen({super.key});

  final EmployeeController employeeController = Get.put(EmployeeController());

  void _showAddEmployeeModal(BuildContext context) {
    final EmployeeController employeeController = Get.find<EmployeeController>();

    // Clear the controllers to ensure no pre-filled data
    employeeController.nameController.clear();
    employeeController.emailController.clear();
    employeeController.phoneController.clear();
    employeeController.passwordController.clear();
    employeeController.passwordConfirmationController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Custom header with wave style
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Center(
                      child: Text(
                        'Add Employee',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Modal content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      TextField(
                        controller: employeeController.nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: employeeController.emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: employeeController.phoneController,
                        decoration: InputDecoration(labelText: 'Phone'),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: employeeController.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: employeeController.passwordConfirmationController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Confirm Password'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context); // Close the modal
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        await employeeController.createEmployee();
                        Navigator.pop(context); // Close the modal after creation
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    employeeController.fetchEmployees();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  // -- AppBar --
                  HomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // -- SearchBar --
                  // SearchConatiner(text: 'Search in store'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Text(
                          'Add Employee',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20,
                              ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            _showAddEmployeeModal(context);
                          },
                          icon: Icon(
                            Iconsax.add,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // -- Categories --
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        // -- Heading --
                        SectionHeading(title: 'Your Categories', showActionButton: false, textColor: Colors.white),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        // -- Categories --
                        HomeCategories(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Employee List
            EmployeeList(),
          ],
        ),
      ),
    );
  }
}
