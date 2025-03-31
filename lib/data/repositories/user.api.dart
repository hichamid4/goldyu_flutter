import 'dart:convert';
import 'dart:io';

import 'package:goldyu/common/models/user.dart';
import 'package:goldyu/data/providers/api_service.dart';

class UserApi {
  static Future<User?> getUser(int id) async {
    // Call the API
    final response = await THttpClient.get('/users/$id');
    if (response.statusCode == HttpStatus.ok) {
      return User.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<User?> updateUser(int id, User user) async {
    // Call the API
    final response = await THttpClient.put('/users/$id', data: user.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return User.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<User?> deleteUser(int id) async {
    // Call the API
    final response = await THttpClient.delete('/users/$id');

    if (response.statusCode == HttpStatus.ok) {
      return User.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<User?> createUser(User user) async {
    // Call the API
    final response = await THttpClient.post('/register', data: user.toJson());

    if (response.statusCode == HttpStatus.created) {
      return User.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<AuthResponse?> login(String email, String password) async {
    final response = await THttpClient.post('/login', data: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<void> logout() async {
    await THttpClient.post('/logout');
  }
}
