import 'dart:convert';
import 'model.dart'; // Create a `Model` class for the models inside the category

class Category {
  final int id;
  final String name;
  final int adminId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Model>? models; // Add models as an optional field

  Category({
    required this.id,
    required this.name,
    required this.adminId,
    this.createdAt,
    this.updatedAt,
    this.models, // Optional: Only available when fetching a single category
  });

  // Convert JSON to Model
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      adminId: json['admin_id'],
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
      models: json['models'] != null ? (json['models'] as List).map((m) => Model.fromJson(m)).toList() : null, // Convert models list if it exists
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'admin_id': adminId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'models': models?.map((m) => m.toJson()).toList(), // Convert models if available
    };
  }

  // Convert List of JSON to List<Category>
  static List<Category> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Category.fromJson(json)).toList();
  }
}
