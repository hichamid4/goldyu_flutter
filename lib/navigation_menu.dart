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
          destinations: controller.destinations, // Use dynamic destinations
        ),
      ),
      body: Obx(() => controller.screens[controller.currentIndex.value]), // Use dynamic screens
    );
  }
}

class NavigationController extends GetxController {
  UserController get userController => Get.find<UserController>();
  final Rx<int> currentIndex = 0.obs;

  // Dynamically generate screens based on user role
  List<Widget> get screens {
    final isAdmin = userController.user.value?.role == 'admin';
    return [
      Obx(() => HomeScreen(data: userController.user.value)),
      Obx(() => SalesScreen()),
      if (isAdmin) Obx(() => EmployeesScreen()), // Only show EmployeesScreen for admins
      Obx(() => ProfileScreen()),
    ];
  }

  // Dynamically generate destinations based on user role
  List<NavigationDestination> get destinations {
    final isAdmin = userController.user.value?.role == 'admin';
    return [
      const NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
      const NavigationDestination(icon: Icon(Iconsax.shop), label: 'Sales'),
      if (isAdmin) const NavigationDestination(icon: Icon(Iconsax.people), label: 'Employees'), // Only show for admins
      const NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
    ];
  }
}
