import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/features/shope/controllers/sale.controller.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SalesFilterWidget extends StatelessWidget {
  final SaleController saleController = Get.find<SaleController>(); // GetX Controller

  SalesFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<Map<String, dynamic>> filters = [
        // {
        //   "icon": LucideIcons.layers,
        //   "hint": "Category",
        //   "items": saleController.categories.map((cat) {
        //     return {"id": cat.id.toString(), "name": cat.name};
        //   }).toList(),
        //   "selected": saleController.selectedCategory.value,
        // },
        {
          "icon": LucideIcons.dollarSign,
          "hint": "Price",
          "items": [
            {"id": "asc", "name": "Low to High"},
            {"id": "desc", "name": "High to Low"}
          ],
          "selected": saleController.priceSort.value,
        },
        {
          "icon": LucideIcons.calendar,
          "hint": "Date",
          "items": [
            {"id": "desc", "name": "Newest"},
            {"id": "asc", "name": "Oldest"}
          ],
          "selected": saleController.dateSort.value,
        },
      ];

      return SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: filters.length,
          itemBuilder: (context, index) {
            final filter = filters[index];
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _buildCustomDropdown(
                context: context,
                icon: filter["icon"],
                hint: filter["hint"],
                items: filter["items"] as List<Map<String, String>>,
                selected: filter["selected"] as String?,
                onSelected: (val) {
                  saleController.updateFilter(filter["hint"], val);
                },
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildCustomDropdown({
    required BuildContext context,
    required IconData icon,
    required String hint,
    required List<Map<String, String>> items,
    required String? selected,
    required ValueChanged<String> onSelected,
  }) {
    // Find the name of the selected item
    final selectedName = items.firstWhere(
      (item) => item["id"] == selected,
      orElse: () => {"id": "", "name": hint},
    )["name"]!;

    return PopupMenuButton<String>(
      onSelected: onSelected,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      itemBuilder: (context) {
        return items.map((item) {
          return PopupMenuItem<String>(
            value: item["id"],
            child: Text(
              item["name"]!,
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Text(
              selectedName, // Display the name of the selected item
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey.shade800),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
