import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/widgets/Texts/section_heading.dart';
import 'package:goldyu/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/features/shope/controllers/employee/employee.controller.dart';
import 'package:goldyu/features/shope/screens/employees/widgets/employees_list.dart';
import 'package:goldyu/features/shope/screens/home/widgets/home_appbar.dart';
import 'package:goldyu/features/shope/screens/home/widgets/home_categories.dart';

class EmployeesScreen extends StatelessWidget {
  EmployeesScreen({super.key});

  final EmployeeController employeeController = Get.put(EmployeeController());

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
                  Center(
                    child: Text(
                      'GOLDY welcomes you',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                    ),
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
