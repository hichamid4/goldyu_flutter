import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/features/shope/controllers/sale.controller.dart';

class AddSaleItemModal extends StatelessWidget {
  final SaleController saleController = Get.find<SaleController>();

  AddSaleItemModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add Sale Item",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Category Dropdown
            DropdownButton<int>(
              hint: const Text("Select Category"),
              value: saleController.selectedCategoryId.value,
              items: saleController.categories.map((category) {
                return DropdownMenuItem(
                  value: category.id,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                saleController.selectCategory(value!);
                print("Selected Category: ${value}");
                print("models ${saleController.categorySelected}");
              },
            ),

            const SizedBox(height: 16),

            // Model Dropdown
            if (saleController.models.isNotEmpty)
              DropdownButton<int>(
                hint: const Text("Select Model"),
                value: saleController.selectedModelId.value,
                items: saleController.models.map((model) {
                  return DropdownMenuItem(
                    value: model.id,
                    child: Text(model.name),
                  );
                }).toList(),
                onChanged: (value) {
                  saleController.selectModel(value!);
                },
              ),

            const SizedBox(height: 16),

            // Type Dropdown
            if (saleController.types.isNotEmpty)
              DropdownButton<int>(
                hint: const Text("Select Type"),
                value: saleController.selectedTypeId.value,
                items: saleController.types.map((type) {
                  return DropdownMenuItem(
                    value: type.id,
                    child: Text(type.name),
                  );
                }).toList(),
                onChanged: (value) {
                  saleController.selectedTypeId.value = value;
                },
              ),

            const SizedBox(height: 16),

            // Quantity Input
            TextField(
              decoration: const InputDecoration(labelText: "Quantity"),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                saleController.quantity.value = int.tryParse(val) ?? 1;
              },
            ),

            const SizedBox(height: 16),

            // Price Input
            TextField(
              decoration: const InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                saleController.price.value = double.tryParse(val) ?? 0.0;
              },
            ),

            const SizedBox(height: 16),

            // Weight Input
            TextField(
              decoration: const InputDecoration(labelText: "Weight"),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                saleController.weight.value = double.tryParse(val) ?? 0.0;
              },
            ),

            const SizedBox(height: 16),

            // Add Item Button
            ElevatedButton(
              onPressed: () {
                saleController.addSaleItem();
                Get.back(); // Close the modal
              },
              child: const Text("Add Item"),
            ),
          ],
        ),
      );
    });
  }
}
