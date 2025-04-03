import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/models/user.dart';
import 'package:goldyu/common/widgets/appbar/appbar.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/features/authentication/controllers/user.controller.dart';
import 'package:goldyu/features/shope/controllers/sale.controller.dart';
import 'package:goldyu/features/shope/screens/sales/widgets/sales.overview.modal.dart';

class SalesAppBar extends StatelessWidget {
  SalesAppBar({
    super.key,
    this.user,
  });

  final User? user;

  final UserController userController = Get.find();
  final SaleController saleController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userController.user.value!.role ?? 'Unknown Role',
            style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey),
          ),
          Text(
            userController.user.value!.name,
            style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add, color: TColors.white), // "+" Icon
          onPressed: () {
            // Open SaleOverviewModal as a centered dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return SaleOverviewModal(); // Display the modal as a dialog
              },
            );
          },
        ),
      ],
    );
  }
}
