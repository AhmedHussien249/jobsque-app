import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/service_locator.dart';

class ApiService {
  final Dio _dio;
  final String _baseUrl = 'https://project2.amit-learning.com/api';

  ApiService(this._dio);

  // GET
 Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParams,
  }) async {
    final token = sl<AppPreferences>().getToken(); // جلب التوكن من shared prefs

    log('[GET] $_baseUrl$endPoint');
    log('[TOKEN] $token');

    final response = await _dio.get(
      '$_baseUrl$endPoint',
      queryParameters: queryParams,
      options: Options(
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );

    return response;
  }

  // POST (FormData)
  Future<Response> post({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParams,
    bool useFormData = true,
  }) async {
    final body = useFormData ? FormData.fromMap(data) : data;
    final response = await _dio.post(
      '$_baseUrl$endPoint',
      data: body,
      queryParameters: queryParams,
    );
    return response;
  }

  // PUT (FormData)
  Future<Response> put({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParams,
    bool useFormData = true,
  }) async {
    final body = useFormData ? FormData.fromMap(data) : data;
    final response = await _dio.put(
      '$_baseUrl$endPoint',
      data: body,
      queryParameters: queryParams,
    );
    return response;
  }

  // DELETE
  Future<Response> delete({
    required String endPoint,
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await _dio.delete(
      '$_baseUrl$endPoint',
      queryParameters: queryParams,
    );
    return response;
  }
}