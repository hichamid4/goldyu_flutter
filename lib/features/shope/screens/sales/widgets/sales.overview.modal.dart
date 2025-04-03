import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/features/shope/controllers/sale.controller.dart';
import 'package:goldyu/features/shope/screens/sales/widgets/add.saleitem.modal.dart';

class SaleOverviewModal extends StatelessWidget {
  SaleOverviewModal({super.key});

  final SaleController saleController = Get.find<SaleController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
        height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with wave style
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Center(
                  child: Text(
                    'Sale Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Content
            Expanded(
              child: Obx(() {
                return Column(
                  children: [
                    // List of Sale Items
                    Expanded(
                      child: saleController.saleItems.isNotEmpty
                          ? ListView.builder(
                              itemCount: saleController.saleItems.length,
                              itemBuilder: (context, index) {
                                final item = saleController.saleItems[index];
                                return ListTile(
                                  title: Text(
                                    "Category: ${item.categoryId}, Model: ${item.modelId}, Type: ${item.typeId}",
                                  ),
                                  subtitle: Text(
                                    "Quantity: ${item.quantity}, Price: ${item.price}, Weight: ${item.weight}",
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      saleController.removeSaleItem(index);
                                    },
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text("No sale items added yet."),
                            ),
                    ),

                    // Buttons Row or Column
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 400) {
                          // Side-by-side buttons if space allows
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Add New Sale Item Button
                                ElevatedButton(
                                  onPressed: () {
                                    Get.bottomSheet(AddSaleItemModal());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  ),
                                  child: const Text("Add New Sale Item"),
                                ),

                                // Save Button
                                ElevatedButton(
                                  onPressed: () async {
                                    await saleController.saveSale();
                                    Get.back(); // Close the modal
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  ),
                                  child: const Text("Save Sale"),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Stack buttons vertically if space is limited
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Get.bottomSheet(AddSaleItemModal());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  ),
                                  child: const Text("Add New Sale Item"),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () async {
                                    await saleController.saveSale();
                                    Get.back(); // Close the modal
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  ),
                                  child: const Text("Save Sale"),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(size.width * 0.25, size.height, size.width * 0.5, size.height - 20);
    path.quadraticBezierTo(size.width * 0.75, size.height - 40, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
