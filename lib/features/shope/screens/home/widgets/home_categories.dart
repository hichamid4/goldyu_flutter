import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/models/category.dart';
import 'package:goldyu/common/models/type.dart';
import 'package:goldyu/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:goldyu/core/constants/image_strings.dart';
import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/features/shope/controllers/categories.controller.dart';
import 'package:goldyu/features/shope/controllers/home/quickSale.controller.dart';

class HomeCategories extends StatelessWidget {
  HomeCategories({super.key});

  final CategoriesController categoriesController = Get.put(CategoriesController());
  final QuickSaleController quickSaleController = Get.put(QuickSaleController());

  // void showQuickSaleBottomSheet(BuildContext context, int categoryId) async {
  //   final quickSaleController = Get.find<QuickSaleController>();

  //   // Fetch models for the selected category
  //   await categoriesController.selectCategory(categoryId);

  //   Get.bottomSheet(
  //     Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: const BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //       ),
  //       child: Obx(() {
  //         final selectedCategory = categoriesController.selectedCategory.value;
  //         final models = selectedCategory?.models ?? [];
  //         List<TypeModel> types = [];

  //         return Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             // Model Dropdown (Shows only models of selected category)
  //             DropdownButton<int>(
  //               hint: const Text("Select Model"),
  //               value: quickSaleController.selectedModelId.value,
  //               items: models.map((model) {
  //                 return DropdownMenuItem(
  //                   value: model.id,
  //                   child: Text(model.name),
  //                 );
  //               }).toList(),
  //               onChanged: (value) {
  //                 quickSaleController.selectedModelId.value = value;
  //                 quickSaleController.selectedTypeId.value = null;
  //                 quickSaleController.loadTypesForModel(value!);
  //                 types = quickSaleController.availableTypes;
  //               },
  //             ),
  //             SizedBox(height: TSizes.spaceBtwItems),

  //             // Type Dropdown (Only appears if a model is selected)
  //             if (quickSaleController.selectedModelId.value != null)
  //               DropdownButton<int>(
  //                 hint: const Text("Select Type"),
  //                 value: quickSaleController.selectedTypeId.value,
  //                 items: types.map((type) {
  //                   return DropdownMenuItem(
  //                     value: type.id,
  //                     child: Text(type.name),
  //                   );
  //                 }).toList(),
  //                 onChanged: (value) {
  //                   quickSaleController.selectedTypeId.value = value;
  //                 },
  //               ),
  //             SizedBox(height: TSizes.spaceBtwItems),

  //             // Quantity Input
  //             TextField(
  //               decoration: const InputDecoration(labelText: "Quantity"),
  //               keyboardType: TextInputType.number,
  //               onChanged: (val) => quickSaleController.quantity.value = int.tryParse(val) ?? 1,
  //             ),
  //             SizedBox(height: TSizes.spaceBtwItems),

  //             // Price Input
  //             TextField(
  //               decoration: const InputDecoration(labelText: "Price"),
  //               keyboardType: TextInputType.number,
  //               onChanged: (val) => quickSaleController.price.value = double.tryParse(val) ?? 0.0,
  //             ),
  //             SizedBox(height: TSizes.spaceBtwItems),

  //             // Weight Input
  //             TextField(
  //               decoration: const InputDecoration(labelText: "Weight"),
  //               keyboardType: TextInputType.number,
  //               onChanged: (val) => quickSaleController.weight.value = double.tryParse(val) ?? 0.0,
  //             ),
  //             SizedBox(height: TSizes.spaceBtwItems),

  //             // Confirm Sale Button
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.blue,
  //                 padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
  //               ),
  //               onPressed: () => quickSaleController.submitSale(),
  //               child: const Text("Confirm Sale"),
  //             ),
  //           ],
  //         );
  //       }),
  //     ),
  //     isScrollControlled: true,
  //   );
  // }

  void showQuickSaleBottomSheet(BuildContext context, int categoryId) async {
    final quickSaleController = Get.find<QuickSaleController>();

    // Fetch models for the selected category
    await categoriesController.selectCategory(categoryId);

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Obx(() {
          final selectedCategory = categoriesController.selectedCategory.value;
          final models = selectedCategory?.models ?? [];

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
                decoration: const InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
                onChanged: (val) => quickSaleController.quantity.value = int.tryParse(val) ?? 1,
              ),
              SizedBox(height: TSizes.spaceBtwItems),

              // Price Input
              TextField(
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                onChanged: (val) => quickSaleController.price.value = double.tryParse(val) ?? 0.0,
              ),
              SizedBox(height: TSizes.spaceBtwItems),

              // Weight Input
              TextField(
                decoration: const InputDecoration(labelText: "Weight"),
                keyboardType: TextInputType.number,
                onChanged: (val) => quickSaleController.weight.value = double.tryParse(val) ?? 0.0,
              ),
              SizedBox(height: TSizes.spaceBtwItems),

              // Confirm Sale Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
                onPressed: () => quickSaleController.submitSale(),
                child: const Text("Confirm Sale"),
              ),
            ],
          );
        }),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: categoriesController.categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoriesController.categories[index];

            return VerticalImageText(
              image: TImages.shoeIcon,
              title: category.name,
              onTap: () {
                quickSaleController.selectedCategoryId.value = category.id;
                showQuickSaleBottomSheet(context, category.id);
              },
            );
          },
        );
      }),
    );
  }
}
