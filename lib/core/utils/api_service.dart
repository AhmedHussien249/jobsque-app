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
    final token = sl<AppPreferences>().getToken();

    log('[GET] $_baseUrl$endPoint');
    log('[TOKEN] $token');
    log('[QUERY PARAMS] $queryParams');

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

    log('[RESPONSE] Status: ${response.statusCode}');
    log('[RESPONSE] Data: ${response.data}');
    return response;
  }

  // POST (FormData)
 Future<Response> post({
  required String endPoint,
  required dynamic data,
  Map<String, dynamic>? queryParams,
  bool useFormData = true,
}) async {
  final token = sl<AppPreferences>().getToken();

  log('[POST] $_baseUrl$endPoint');
  log('[TOKEN] $token');
  log('[DATA] $data');
  log('[QUERY PARAMS] $queryParams');

  // لو data أصلاً FormData سيبها زي ما هي
  final body = (data is FormData) ? data : (useFormData ? FormData.fromMap(data) : data);

  final response = await _dio.post(
    '$_baseUrl$endPoint',
    data: body,
    queryParameters: queryParams,
    options: Options(
      headers: {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    ),
  );

  log('[RESPONSE] Status: ${response.statusCode}');
  log('[RESPONSE] Data: ${response.data}');
  return response;
}

  // PUT (FormData)
  Future<Response> put({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParams,
    bool useFormData = true,
  }) async {
    final token = sl<AppPreferences>().getToken();

    log('[PUT] $_baseUrl$endPoint');
    log('[TOKEN] $token');
    log('[DATA] $data');
    log('[QUERY PARAMS] $queryParams');

    final body = useFormData ? FormData.fromMap(data) : data;
    final response = await _dio.put(
      '$_baseUrl$endPoint',
      data: body,
      queryParameters: queryParams,
      options: Options(
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );

    log('[RESPONSE] Status: ${response.statusCode}');
    log('[RESPONSE] Data: ${response.data}');
    return response;
  }

  // DELETE
  Future<Response> delete({
    required String endPoint,
    Map<String, dynamic>? queryParams,
  }) async {
    final token = sl<AppPreferences>().getToken();

    log('[DELETE] $_baseUrl$endPoint');
    log('[TOKEN] $token');
    log('[QUERY PARAMS] $queryParams');

    final response = await _dio.delete(
      '$_baseUrl$endPoint',
      queryParameters: queryParams,
      options: Options(
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );

    log('[RESPONSE] Status: ${response.statusCode}');
    log('[RESPONSE] Data: ${response.data}');
    return response;
  }
}
