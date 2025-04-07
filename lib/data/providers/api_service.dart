import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:goldyu/core/helpers/secure_storage_helper.dart';

class THttpClient {
  static const String baseUrl = 'https://web-production-c36bb.up.railway.app/api';

  /// GET request
  static Future<http.Response> get(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildHeaders();
    try {
      return await http.get(uri, headers: headers);
    } catch (e) {
      rethrow;
    }
  }

  /// POST request
  static Future<http.Response> post(String endpoint, {dynamic data}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildHeaders();
    try {
      return await http.post(uri, headers: headers, body: jsonEncode(data));
    } catch (e) {
      rethrow;
    }
  }

  /// PUT request
  static Future<http.Response> put(String endpoint, {dynamic data}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildHeaders();
    try {
      return await http.put(uri, headers: headers, body: jsonEncode(data));
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE request
  static Future<http.Response> delete(String endpoint, {dynamic data}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildHeaders();
    try {
      return await http.delete(uri, headers: headers, body: jsonEncode(data));
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, String>> validateToken(String token) async {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  /// Build headers with Authorization token and default content type
  static Future<Map<String, String>> _buildHeaders() async {
    String? token = await SecureStorageHelper.getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
