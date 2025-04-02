import 'dart:convert';
import 'dart:io';
import 'package:goldyu/common/models/model.dart';
import 'package:goldyu/data/providers/api_service.dart';

class ModelApi {
  /// Fetch all Model
  static Future<List<Model>> getModels() async {
    final response = await THttpClient.get('/models');
    if (response.statusCode == HttpStatus.ok) {
      return (jsonDecode(response.body) as List).map((e) => Model.fromJson(e)).toList();
    }
    return [];
  }

  /// Fetch a single Model by ID
  static Future<Model?> getModel(int id) async {
    final response = await THttpClient.get('/models/$id');
    if (response.statusCode == HttpStatus.ok) {
      return Model.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Create a new category
  static Future<Model?> createModel(String name) async {
    final response = await THttpClient.post('/models', data: {'name': name});

    if (response.statusCode == HttpStatus.created) {
      return Model.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Update an existing
  static Future<Model?> updateModel(int id, Model model) async {
    final response = await THttpClient.put('/models/$id', data: model.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return Model.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  /// Delete a category
  static Future<bool> deleteModel(int id) async {
    final response = await THttpClient.delete('/models/$id');
    return response.statusCode == HttpStatus.ok;
  }
}
