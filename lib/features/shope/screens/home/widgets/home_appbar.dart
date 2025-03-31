import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/models/user.dart';
import 'package:goldyu/common/widgets/appbar/appbar.dart';
import 'package:goldyu/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/features/authentication/controllers/login.controller.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({
    super.key,
    required this.user,
  });

  final User user;

  final LoginController loginController = Get.put(LoginController());
  

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.role, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey)),
          Text(user.name, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)),
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
