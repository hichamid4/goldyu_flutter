import 'package:get/get.dart';
import 'package:goldyu/common/models/category.dart';
import 'package:goldyu/common/models/sale.dart';
import 'package:goldyu/common/models/saleItem.dart';
import 'package:goldyu/data/providers/api_service.dart';
import 'package:goldyu/data/repositories/category.api.dart';
import 'package:goldyu/data/repositories/sales.api.dart';

class SaleController extends GetxController {
  var sales = <Sale>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var categories = <Category>[].obs;
  var selectedCategory = RxnString();
  var priceSort = RxnString();
  var dateSort = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchSales();
    fetchCategories();
  }

  // fetch categories
  Future<void> fetchCategories() async {
    try {
      var fetchedCategories = await CategoryApi.getCategories();
      categories.assignAll(fetchedCategories);
      print("Fetched Categories: $categories"); // Debug print
    } catch (e) {
      errorMessage.value = "Error fetching categories.";
      print("fetchCategories Error: $e");
    }
  }

  void updateFilter(String filterType, String value) {
    if (filterType == "Category") {
      selectedCategory.value = value;
    } else if (filterType == "Price") {
      priceSort.value = value;
    } else if (filterType == "Date") {
      dateSort.value = value;
    }
    fetchFSales(); // Fetch updated sales list
  }

  void fetchFSales() async {
    var filters = {
      "category_id": selectedCategory.value,
      "price_sort": priceSort.value,
      "date_sort": dateSort.value,
    };
    // Call API with filters
    String filterString = filters.entries
        .where((entry) => entry.value != null) // Exclude null values
        .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value!)}')
        .join('&');
    await SalesApi.getFSales(filterString);
  }

  Future<void> fetchSales() async {
    try {
      isLoading(true);
      var response = await SalesApi.getSales();

      // Check if the response is a List of sales
      if (response.isNotEmpty) {
        sales.assignAll(response);
        errorMessage.value = ''; // Clear error on success
      } else {
        errorMessage.value = "No sales found.";
      }
    } catch (e) {
      errorMessage.value = "Error fetching sales.";
      print("fetchSales Error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchFilteredSales(String filters) async {
    try {
      isLoading(true);
      var response = await SalesApi.getFSales(filters);

      // Check if the response is a List of sales
      if (response.isNotEmpty) {
        sales.assignAll(response);
        errorMessage.value = ''; // Clear error on success
      } else {
        errorMessage.value = "No sales found.";
      }
    } catch (e) {
      errorMessage.value = "Error fetching filtered sales.";
      print("fetchSales Error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addSale(List<SaleItem> saleItems) async {
    try {
      isLoading(true);
      final response = await THttpClient.post('/sales', data: {
        'sale_items': saleItems.map((item) => item.toJson()).toList(),
      });
      if (response != null) {
        sales.insert(0, Sale.fromJson(response as Map<String, dynamic>));
      }
    } catch (e) {
      print("Error adding sale: $e");
    } finally {
      isLoading(false);
    }
  }
}
