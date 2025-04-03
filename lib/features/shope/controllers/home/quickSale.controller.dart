import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/models/category.dart';
import 'package:goldyu/common/models/saleItem.dart';
import 'package:goldyu/common/models/type.dart';
import 'package:goldyu/data/providers/api_service.dart';
import 'package:goldyu/data/repositories/model.api.dart';
import 'package:goldyu/features/shope/controllers/sale.controller.dart';

class QuickSaleController extends GetxController {
  final SaleController _saleController = Get.put(SaleController());
  var selectedCategoryId = RxnInt();
  var selectedModelId = RxnInt();
  var selectedTypeId = RxnInt();

  var category = Rxn<Category>();
  var availableTypes = <TypeModel>[].obs;

  var quantity = 1.obs;
  var price = 0.0.obs;
  var weight = 0.0.obs;

  Future<void> loadTypesForModel(int modelId) async {
    try {
      var model = await ModelApi.getModel(modelId);
      availableTypes.assignAll(model?.types ?? []);
      print("Available Types: ${availableTypes}");
      print("Available model: ${model}");
    } catch (e) {
      availableTypes.clear();
    }
  }

  void resetSelection() {
    selectedCategoryId.value = selectedCategoryId.value;
    selectedModelId.value = null;
    selectedTypeId.value = null;
    quantity.value = 1;
    price.value = 0.0;
    weight.value = 0.0;
  }

  void submitSale() async {
    if (selectedCategoryId.value == null || selectedModelId.value == null || selectedTypeId.value == null) {
      resetSelection();
      Get.snackbar(
        "Error",
        "Please complete the sale details",
        backgroundColor: const Color.fromARGB(255, 194, 99, 92),
        colorText: Colors.white,
      );
      return;
    }

    final saleItem = SaleItem(
      id: 0, // Assuming the sale item doesn't have an ID until it's created on the backend
      saleId: 0, // Backend will assign this ID after creating the sale
      categoryId: selectedCategoryId.value!,
      modelId: selectedModelId.value!,
      typeId: selectedTypeId.value!,
      quantity: quantity.value,
      price: price.value,
      weight: weight.value,
      pricePerGram: price.value / (weight.value != 0 ? weight.value : 1), // Calculate price per gram if weight is available
    );

    // Prepare the sale data
    final saleData = {
      "sale_items": [
        saleItem.toJson(), // Convert the SaleItem object to JSON
      ],
      "total_price": price.value, // You can calculate total price based on the sale items if needed
      "total_weight": weight.value, // Similarly, calculate total weight
    };

    try {
      // Send data to the backend using the API
      final response = await THttpClient.post('/sales', data: saleData);

      if (response.statusCode == 201) {
        resetSelection(); // Reset the fields after successful submission
        await _saleController.fetchFilteredSales('today=true');
        Get.back(); // Close the BottomSheet after submission
        Get.snackbar(
          "Success",
          "Sale submitted successfully!",
          backgroundColor: Colors.greenAccent,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar("Error", "Failed to submit sale. Please try again.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while submitting the sale.");
      print("Error: $e");
    }
  }
}
