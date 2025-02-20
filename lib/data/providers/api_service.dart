import 'package:dio/dio.dart';
import 'package:goldyu/core/helpers/secure_storage_helper.dart';

class DioClient {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://your-backend-url.com'));

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add token to the headers
          String? token = await SecureStorageHelper.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options); // Continue the request
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Handle invalid token
            await SecureStorageHelper.deleteToken();
            print('Token is invalid. Redirecting to login...');
            // Optionally, show a dialog or navigate to login
          }
          return handler.next(error);
        },
      ),
    );
  }

  /// GET request
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      return await _dio.get(endpoint,
          queryParameters: queryParameters, options: Options(headers: headers));
    } catch (e) {
      rethrow; // Let the caller handle errors
    }
  }

  /// POST request
  Future<Response> post(String endpoint,
      {dynamic data, Map<String, dynamic>? headers}) async {
    try {
      return await _dio.post(endpoint,
          data: data, options: Options(headers: headers));
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE request
  Future<Response> delete(String endpoint,
      {dynamic data, Map<String, dynamic>? headers}) async {
    try {
      return await _dio.delete(endpoint,
          data: data, options: Options(headers: headers));
    } catch (e) {
      rethrow;
    }
  }
}
