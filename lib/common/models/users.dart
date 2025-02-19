class User {
  final String name;
  final String email;
  final String
      password; // Add a placeholder or handle it separately since it's not in the response
  final String role;
  final int? adminId; // Nullable

  User({
    required this.name,
    required this.email,
    this.password = '', // Default value if not provided
    required this.role,
    this.adminId, // Nullable
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: '*****', // Password is not in the response
      role: json['role'],
      adminId: json['admin_id'], // Nullable
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'admin_id': adminId,
    };
  }
}
