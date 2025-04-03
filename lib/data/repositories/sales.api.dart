import 'dart:convert';
import 'dart:io';
import 'package:goldyu/common/models/category.dart';
import 'package:goldyu/common/models/model.dart';
import 'package:goldyu/common/models/sale.dart';
import 'package:goldyu/common/models/saleItem.dart';
import 'package:goldyu/common/models/type.dart';
import 'package:goldyu/data/providers/api_service.dart';
import 'package:goldyu/data/repositories/category.api.dart';

class SalesApi {
  static Future<List<Category>> getCategories() async {
    final response = await THttpClient.get('/categories');
    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);

      // Extract the "data" field, which contains the list of categories
      if (body['data'] is List) {
        return (body['data'] as List).map((i) => Category.fromJson(i)).toList();
      } else {
        return [];
      }
    }
    return [];
  }

  // Fetch all
  static Future<List<Sale>> getSales() async {
    final response = await THttpClient.get('/sales');
    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);

      // Extract the "data" field, which contains the list of sales
      if (body['data'] is List) {
        return (body['data'] as List).map((i) => Sale.fromJson(i)).toList();
      } else {
        return [];
      }
    }
    return [];
  }

  // fetch filtered
  static Future<List<Sale>> getFSales(String filters) async {
    final response = await THttpClient.get('/sales?$filters');
    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);

      // Extract the "data" field, which contains the list of sales
      if (body['data'] is List) {
        return (body['data'] as List).map((i) => Sale.fromJson(i)).toList();
      } else {
        return [];
      }
    }
    return [];
  }

  /// Fetch a single
  static Future<Sale?> getSale(int id) async {
    final response = await THttpClient.get('/sales/$id');
    if (response.statusCode == HttpStatus.ok) {
      return Sale.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<Sale?> createSale(List<SaleItem> saleItems) async {
    final response = await THttpClient.post(
      '/sales',
      data: {
        'sale_items': saleItems.map((item) => item.toJson()).toList(),
      },
    );

    if (response.statusCode == HttpStatus.created) {
      return Sale.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Update an existing sale with new sale items
  static Future<Sale?> updateSale(int id, List<SaleItem> saleItems) async {
    final response = await THttpClient.put(
      '/sales/$id',
      data: {
        'sale_items': saleItems.map((item) => item.toJson()).toList(),
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return Sale.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Delete a sale
  static Future<bool> deleteSale(int id) async {
    final response = await THttpClient.delete('/sales/$id');
    return response.statusCode == HttpStatus.ok;
  }

  // Fetch models by category ID
  static Future<List<Model>> getModelsByCategory(int categoryId) async {
    final response = await THttpClient.get('/categories/$categoryId/models');
    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      if (body['data'] is List) {
        return (body['data'] as List).map((i) => Model.fromJson(i)).toList();
      }
    }
    return [];
  }

  // Fetch types by model ID
  static Future<List<TypeModel>> getTypesByModel(int modelId) async {
    final response = await THttpClient.get('/models/$modelId');
    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      if (body['data'] is List) {
        return (body['data'] as List).map((i) => TypeModel.fromJson(i)).toList();
      }
    }
    return [];
  }
}
