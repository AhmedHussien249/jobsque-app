import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/core/utils/api_service.dart';
import 'package:jobsque/features/profile/data/models/portfolio_model_response.dart';
import '../models/edit_profile_model.dart';
import 'profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiService apiService;
  ProfileRepoImpl(this.apiService);

  @override
  Future<EditProfileModel> editProfile({
    required Map<String, dynamic> queryParams,
  }) async {
    try {
      // ApiService.put signature: endPoint, data (Map), queryParams, useFormData
      final response = await apiService.put(
        endPoint: '/user/profile/edit',
        data: {}, // لازم تمرر data لأن الدالة مطلوبة، حتى لو بنرسل البيانات كـ queryParams
        queryParams: queryParams,
        useFormData: false,
      );

      log('editProfile response status: ${response.statusCode}');
      log('editProfile response data: ${response.data}');

      final resp = response.data;
      if (resp is Map<String, dynamic> && resp['data'] is Map<String, dynamic>) {
        return EditProfileModel.fromJson(resp['data'] as Map<String, dynamic>);
      } else {
        // لو السيرفر رجع شكل غير متوقع
        throw const ServerFailure('Unexpected server response format.');
      }
    } on DioException catch (dioErr) {
      // تحويل DioException لـ ServerFailure بطريقة موحدة
      throw ServerFailure.fromDioError(dioErr);
    } catch (e) {
      log('editProfile unexpected error: $e');
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<PortfolioResponseModel> getPortfolio() async {
    try {
      final response = await apiService.get(endPoint: '/user/profile/portofolios');
      log('getPortfolio response status: ${response.statusCode}');
      log('getPortfolio response data: ${response.data}');

      final resp = response.data;
      if (resp is Map<String, dynamic>) {
        return PortfolioResponseModel.fromJson(resp);
      } else {
        throw const ServerFailure('Unexpected server response format.');
      }
    } on DioException catch (dioErr) {
      throw ServerFailure.fromDioError(dioErr);
    } catch (e) {
      log('getPortfolio unexpected error: $e');
      throw ServerFailure(e.toString());
    }
  }
}
