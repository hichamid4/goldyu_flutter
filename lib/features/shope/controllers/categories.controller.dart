import 'package:get/get.dart';
import 'package:goldyu/common/models/category.dart';
import 'package:goldyu/data/repositories/category.api.dart';

class CategoriesController extends GetxController {
  static CategoriesController get instance => Get.find();

  var categories = <Category>[].obs;
  var selectedCategory = Rxn<Category>(); // Holds the selected category
  var errorMessage = ''.obs;
  var isLoading = false.obs; // Loading state for fetching single category

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  /// Fetch all categories from API
  Future<void> fetchCategories() async {
    try {
      var fetchedCategories = await CategoryApi.getCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      errorMessage.value = "Error fetching categories.";
    }
  }

  /// Select a category and fetch its models
  Future<void> selectCategory(int categoryId) async {
    isLoading.value = true;
    try {
      var category = await CategoryApi.getCategory(categoryId); // Fetch single category with models
      if (category != null) {
        selectedCategory.value = category;
      }
    } catch (e) {
      errorMessage.value = "Error fetching category details.";
    } finally {
      isLoading.value = false;
    }
  }

  /// Create a new category
  Future<void> addCategory(String name) async {
    try {
      var newCategory = await CategoryApi.createCategory(name);
      if (newCategory != null) {
        categories.add(newCategory);
      }
    } catch (e) {
      errorMessage.value = "Error adding category.";
    }
  }

  /// Update an existing category
  Future<void> updateCategory(int id, Category category) async {
    try {
      var updatedCategory = await CategoryApi.updateCategory(id, category);
      if (updatedCategory != null) {
        int index = categories.indexWhere((c) => c.id == id);
        if (index != -1) {
          categories[index] = updatedCategory;
        }
      }
    } catch (e) {
      errorMessage.value = "Error updating category.";
    }
  }

  /// Delete a category
  Future<void> deleteCategory(int id) async {
    try {
      bool success = await CategoryApi.deleteCategory(id);
      if (success) {
        categories.removeWhere((c) => c.id == id);
      }
    } catch (e) {
      errorMessage.value = "Error deleting category.";
    }
  }
}
