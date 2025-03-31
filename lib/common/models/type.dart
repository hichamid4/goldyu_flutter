class TypeModel {
  final int id;
  final String name;

  TypeModel({required this.id, required this.name});

  // Factory method to create TypeModel from JSON
  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      id: json['id'],
      name: json['name'],
    );
  }

  // Convert TypeModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
