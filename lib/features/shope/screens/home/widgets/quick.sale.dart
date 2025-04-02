import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:goldyu/common/models/model.dart';
import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/features/shope/controllers/home/quickSale.controller.dart';

class QuickSale extends StatelessWidget {
  const QuickSale({
    super.key,
    required this.quickSaleController,
    required this.models,
  });

  final QuickSaleController quickSaleController;
  final List<Model> models;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Model Dropdown (Shows only models of selected category)
        DropdownButton<int>(
          hint: const Text("Select Model"),
          value: quickSaleController.selectedModelId.value,
          items: models.map((model) {
            return DropdownMenuItem(
              value: model.id,
              child: Text(model.name),
            );
          }).toList(),
          onChanged: (value) {
            quickSaleController.selectedModelId.value = value;
            quickSaleController.selectedTypeId.value = null;
            quickSaleController.loadTypesForModel(value!); // Fetch types
          },
        ),
        SizedBox(height: TSizes.spaceBtwItems),

        // Type Dropdown (Only appears if a model is selected)
        Obx(() => quickSaleController.availableTypes.isNotEmpty
            ? DropdownButton<int>(
                hint: const Text("Select Type"),
                value: quickSaleController.selectedTypeId.value,
                items: quickSaleController.availableTypes.map((type) {
                  return DropdownMenuItem(
                    value: type.id,
                    child: Text(type.name),
                  );
                }).toList(),
                onChanged: (value) {
                  quickSaleController.selectedTypeId.value = value;
                },
              )
            : const SizedBox()), // Hide if no types available
        SizedBox(height: TSizes.spaceBtwItems),

        // Quantity Input
        TextField(
          controller: TextEditingController(text: quickSaleController.quantity.value.toString()),
          decoration: const InputDecoration(labelText: "Quantity"),
          keyboardType: TextInputType.number,
          onChanged: (val) => quickSaleController.quantity.value = int.tryParse(val) ?? 1,
        ),
        SizedBox(height: TSizes.spaceBtwItems),

        // Price Input
        TextField(
          controller: TextEditingController(text: quickSaleController.price.value.toString()),
          decoration: const InputDecoration(labelText: "Price"),
          keyboardType: TextInputType.number,
          onChanged: (val) => quickSaleController.price.value = double.tryParse(val) ?? 0.0,
        ),
        SizedBox(height: TSizes.spaceBtwItems),

        // Weight Input
        TextField(
          controller: TextEditingController(text: quickSaleController.weight.value.toString()),
          decoration: const InputDecoration(labelText: "Weight"),
          keyboardType: TextInputType.number,
          onChanged: (val) => quickSaleController.weight.value = double.tryParse(val) ?? 0.0,
        ),
        SizedBox(height: TSizes.spaceBtwItems),

        // Confirm Sale Button
        SizedBox(
          // width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            ),
            child: const Text("Confirm Sale"),
            onPressed: () {
              quickSaleController.submitSale();
              // Handle sale confirmation logic here
            },
          ),
        ),
      ],
    );
  }
}
