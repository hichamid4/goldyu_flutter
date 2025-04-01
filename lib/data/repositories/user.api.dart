import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
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

  static Future<AuthResponse?> login(String email, String password, bool remember) async {
    final response = await THttpClient.post('/login', data: {
      'email': email,
      'password': password,
      'remember': remember,
    });

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<User?> validateToken(String token) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/validate-token'),
        headers: {
          'Authorization': 'Bearer $token', // Pass the token for validation
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return User.fromJson(json);
      } else {
        return null; // Token is invalid
      }
    } catch (e) {
      return null; // Error in making the request
    }
  }

  static Future<void> logout() async {
    await THttpClient.post('/logout');
  }
}
