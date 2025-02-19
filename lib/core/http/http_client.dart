import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class THttpHelper {
  final Dio dio = Dio();

  THttpHelper() {
    dio.options.baseUrl = 'http://10.0.2.2:8000';
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    _initializeCSRFToken();
  }

  // Initialize CSRF token when the ApiService is created
  Future<void> _initializeCSRFToken() async {
    try {
      await _getOrReplaceCSRFToken();
    } catch (e) {
      print('Error initializing CSRF token: $e');
    }
  }

  // Method to check if CSRF token exists
  Future<void> _checkCSRFTokenExists() async {
    if (await _isCSRFTokenExpired()) {
      await _setCSRFToken();
    } else {
      _getOrReplaceCSRFToken();
    }
  }

  // Method to check if CSRF token is expired
  Future<bool> _isCSRFTokenExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? tokenTimestamp = prefs.getInt('csrf_token_timestamp');

    if (tokenTimestamp == null) {
      return true; // Token does not exist
    }

    // Check if token expired (120 minutes = 7200 seconds)
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int expirationDurationInSeconds = 120 * 60; // 120 minutes in seconds

    return (currentTimestamp - tokenTimestamp) > expirationDurationInSeconds;
  }

  // Method to get or replace CSRF token
  Future<void> _getOrReplaceCSRFToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? csrfToken = prefs.getString('csrf_token');
      dio.options.headers['X-XSRF-TOKEN'] = csrfToken;
    } catch (e) {
      print('Error checking or replacing CSRF token: $e');
      rethrow;
    }
  }

  // Fetch and set CSRF token from the server
  Future<void> _setCSRFToken() async {
    try {
      var response = await dio.get('/sanctum/csrf-cookie');
      String? xsrfToken = _getCookie('XSRF-TOKEN', response);

      if (xsrfToken != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('csrf_token', xsrfToken);

        // Store the timestamp of when the token was fetched
        int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        await prefs.setInt('csrf_token_timestamp', currentTimestamp);

        dio.options.headers['X-XSRF-TOKEN'] = xsrfToken;
      } else {
        print('CSRF token not found in cookies.');
      }
    } catch (e) {
      print('Error fetching CSRF token: $e');
      rethrow;
    }
  }

  // Helper function to extract CSRF token from cookies
  String? _getCookie(String cookieName, Response response) {
    var cookies = response.headers.map['set-cookie'];
    if (cookies != null) {
      for (var cookie in cookies) {
        if (cookie.contains(cookieName)) {
          var token = cookie.split(';')[0];
          return token.split('=').last;
        }
      }
    }
    return null;
  }

  // ------------------------------------------------------------------------------------------

  // GET Request
  Future<Map<String, dynamic>> getRequest(String endpoint) async {
    try {
      final instance = THttpHelper();
      await instance._checkCSRFTokenExists();
      final response = await dio.get(endpoint);
      return _handleResponse(response);
    } catch (e) {
      print('Error fetching user: $e');
      rethrow;
    }
  }

  // Post Request
  Future<Map<String, dynamic>> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final instance = THttpHelper();
      await instance._checkCSRFTokenExists();
      final response = await dio.post(endpoint, data: data);
      return _handleResponse(response);
    } catch (e) {
      print('Error adding user: $e');
      rethrow;
    }
  }

  // Put Request
  Future<Map<String, dynamic>> putRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final instance = THttpHelper();
      await instance._checkCSRFTokenExists();
      final response = await dio.put(endpoint, data: data);
      return _handleResponse(response);
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  // Delete Request
  static Future<Map<String, dynamic>> deleteRequest(String endpoint) async {
    try {
      final instance = THttpHelper();
      await instance._checkCSRFTokenExists();
      final response = await instance.dio.delete(endpoint);
      return _handleResponse(response);
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }

  //  handle the http response
  static Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.data);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
