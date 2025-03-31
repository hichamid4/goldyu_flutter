import 'type.dart';

class Model {
  final int id;
  final String name;
  final List<TypeModel> types;

  Model({
    required this.id,
    required this.name,
    required this.types,
  });

  // Factory method to create Model from JSON
  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'],
      name: json['name'],
      types: (json['types'] as List<dynamic>?)?.map((type) => TypeModel.fromJson(type)).toList() ?? [],
    );
  }

  // Convert Model instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'types': types.map((type) => type.toJson()).toList(),
    };
  }
}
