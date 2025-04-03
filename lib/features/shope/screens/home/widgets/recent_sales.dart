import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/features/shope/controllers/sale.controller.dart';
import 'package:goldyu/features/shope/screens/home/widgets/sale_card.dart';

class RecentSales extends StatelessWidget {
  RecentSales({super.key});

  final SaleController saleController = Get.put(SaleController());

  @override
  Widget build(BuildContext context) {
    // Fetch filtered sales for today
    saleController.fetchFilteredSales('today=true');

    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Obx(() {
        if (saleController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (saleController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              saleController.errorMessage.value,
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        if (saleController.sales.isEmpty) {
          return const Center(
            child: Text(
              "No sales found.",
              style: TextStyle(color: TColors.darkGrey),
            ),
          );
        }

        return SizedBox(
          height: 400,
          child: SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              physics: const AlwaysScrollableScrollPhysics(),
              // shrinkWrap: true,
              itemCount: saleController.sales.length, // Dynamically set the item count
              itemBuilder: (context, index) {
                final sale = saleController.sales[index];
                // Example data for SaleCard
                return SaleCard(
                  userName: 'hicham', // Replace with dynamic data if necessary
                  totalPrice: sale.totalPrice,
                  totalWeight: sale.totalWeight,
                  saleDate: sale.saleDate != null ? sale.saleDate!.toString().substring(0, 10) : 'N/A',
                  saleTime: sale.saleDate != null ? sale.saleDate!.toString().substring(11, 16) : 'N/A',
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
