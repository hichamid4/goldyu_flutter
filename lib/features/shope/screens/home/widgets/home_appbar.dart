import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/models/user.dart';
import 'package:goldyu/common/widgets/appbar/appbar.dart';
import 'package:goldyu/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/features/authentication/controllers/login.controller.dart';
import 'package:goldyu/features/authentication/controllers/user.controller.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({
    super.key,
    this.user,
  });

  final User? user;

  final LoginController loginController = Get.put(LoginController());
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userController.user.value!.role ?? 'Unknown Role', style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey)),
          Text(userController.user.value!.name, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)),
        ],
      ),
      actions: [
        CartCounterIcon(
          iconColor: TColors.white,
          onPressed: loginController.logout,
        )
      ],
    );
  }
}
