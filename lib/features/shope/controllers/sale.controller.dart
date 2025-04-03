import 'package:get/get.dart';
import 'package:goldyu/common/models/category.dart';
import 'package:goldyu/common/models/model.dart';
import 'package:goldyu/common/models/sale.dart';
import 'package:goldyu/common/models/saleItem.dart';
import 'package:goldyu/common/models/type.dart';
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

  var models = <Model>[].obs;
  var types = <TypeModel>[].obs;

  var categorySelected = Rxn<Category>();
  var selectedCategoryId = RxnInt();
  var selectedModelId = RxnInt();
  var selectedTypeId = RxnInt();

  var quantity = 1.obs;
  var price = 0.0.obs;
  var weight = 0.0.obs;

  var saleItems = <SaleItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      var fetchedCategories = await CategoryApi.getCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      print("Error fetching categories: $e");
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
    fetchFilteredSales();
  }

  // fetch today sales
  Future<void> fetchTodaySales() async {
    try {
      isLoading(true);
      var response = await SalesApi.getFSales('today=true');
      if (response.isNotEmpty) {
        sales.assignAll(response);
        errorMessage.value = ''; // Clear error on success
      } else {
        errorMessage.value = "No sales found for today.";
      }
    } catch (e) {
      errorMessage.value = "Error fetching today's sales.";
      print("fetchTodaySales Error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchFilteredSales() async {
    try {
      var filters = {
        "category_id": selectedCategory.value,
        "price_sort": priceSort.value,
        "date_sort": dateSort.value,
      };

      // Convert filters to query string
      String queryString = filters.entries.where((entry) => entry.value != null).map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value!)}').join('&');

      var sales = await SalesApi.getFSales(queryString);
      // Handle sales data (e.g., update observable list)
      if (sales.isNotEmpty) {
        this.sales.assignAll(sales);
        errorMessage.value = ''; // Clear error on success
      } else {
        errorMessage.value = "No sales found with the selected filters.";
      }
    } catch (e) {
      print("Error fetching filtered sales: $e");
    }
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

  void selectCategory(int categoryId) {
    // Find the selected category by its ID
    final selectedCategory = categories.firstWhere((category) => category.id == categoryId);

    // Assign the selected category to categorySelected
    categorySelected.value = selectedCategory;

    // Reset model and type selections
    selectedModelId.value = null;
    selectedTypeId.value = null;

    // Clear the types list
    types.clear();

    // Assign the models of the selected category to the models list
    models.assignAll(selectedCategory.models ?? []);

    // Debugging
    print("Selected Category: ${categorySelected.value?.name}");
    print("Assigned Models: ${models.map((model) => model.name).toList()}");
  }

  Future<void> selectModel(int modelId) async {
    selectedModelId.value = modelId;
    selectedTypeId.value = null; // Reset type selection
    types.clear();

    try {
      // Fetch types for the selected model
      final fetchedTypes = await SalesApi.getTypesByModel(modelId);
      types.assignAll(fetchedTypes);
    } catch (e) {
      print("Error fetching types: $e");
    }
  }

  void addSaleItem() {
    saleItems.add(SaleItem(
      categoryId: selectedCategoryId.value!,
      modelId: selectedModelId.value!,
      typeId: selectedTypeId.value!,
      quantity: quantity.value,
      price: price.value,
      weight: weight.value,
    ));
  }

  void removeSaleItem(int index) {
    saleItems.removeAt(index);
  }

  Future<void> saveSale() async {
    // Send saleItems to the backend
    await SalesApi.createSale(saleItems);
  }
}
