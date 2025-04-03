import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/models/user.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/core/helpers/helper_functions.dart';
import 'package:goldyu/features/authentication/controllers/user.controller.dart';
import 'package:goldyu/features/shope/screens/employees/employees_screen.dart';
import 'package:goldyu/features/shope/screens/home/home.dart';
import 'package:goldyu/features/shope/screens/profile/profile.dart';
import 'package:goldyu/features/shope/screens/sales/sales_screen.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: (index) {
            controller.currentIndex.value = index;
          },
          backgroundColor: dark ? Colors.black : Colors.white,
          indicatorColor: dark ? TColors.white.withOpacity(0.1) : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Sales'),
            NavigationDestination(icon: Icon(Iconsax.people), label: 'Employees'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.currentIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> currentIndex = 0.obs;

  UserController get userController => Get.find<UserController>();

  List<Widget> get screens => [
        Obx(() => HomeScreen(data: userController.user.value)),
        Obx(() => SalesScreen()),
        Obx(() => EmployeesScreen()),
        Obx(() => ProfileScreen()),
      ];
}
