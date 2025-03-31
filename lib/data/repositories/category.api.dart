import 'dart:convert';
import 'dart:io';
import 'package:goldyu/common/models/category.dart';
import 'package:goldyu/data/providers/api_service.dart';

class CategoryApi {
  /// Fetch all categories
  static Future<List<Category>> getCategories() async {
    final response = await THttpClient.get('/categories');
    if (response.statusCode == HttpStatus.ok) {
      return (jsonDecode(response.body) as List).map((e) => Category.fromJson(e)).toList();
    }
    return [];
  }

  /// Fetch a single category by ID
  static Future<Category?> getCategory(int id) async {
    final response = await THttpClient.get('/categories/$id');
    if (response.statusCode == HttpStatus.ok) {
      return Category.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Create a new category
  static Future<Category?> createCategory(String name) async {
    final response = await THttpClient.post('/categories', data: {'name': name});

    if (response.statusCode == HttpStatus.created) {
      return Category.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Update an existing category
  static Future<Category?> updateCategory(int id, Category category) async {
    final response = await THttpClient.put('/categories/$id', data: category.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return Category.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Delete a category
  static Future<bool> deleteCategory(int id) async {
    final response = await THttpClient.delete('/categories/$id');
    return response.statusCode == HttpStatus.ok;
  }
}
