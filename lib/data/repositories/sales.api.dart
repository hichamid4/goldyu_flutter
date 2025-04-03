import 'dart:convert';
import 'dart:io';
import 'package:goldyu/common/models/sale.dart';
import 'package:goldyu/data/providers/api_service.dart';

class SalesApi {
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

  /// Create
  static Future<Sale?> createSale(String name) async {
    final response = await THttpClient.post('/sales', data: {'name': name});

    if (response.statusCode == HttpStatus.created) {
      return Sale.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Update an existing
  static Future<Sale?> updateSale(int id, Sale sale) async {
    final response = await THttpClient.put('/sales/$id', data: sale.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return Sale.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Delete a category
  static Future<bool> deleteSAle(int id) async {
    final response = await THttpClient.delete('/sales/$id');
    return response.statusCode == HttpStatus.ok;
  }
}
