import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/core/utils/api_service.dart';
import 'package:jobsque/features/auth/data/models/register_model.dart';
import 'package:jobsque/features/auth/data/models/user_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;

  AuthRepoImpl(this.apiService);

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        endPoint: '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final user = UserModel.fromJson(response.data);
      return Right(user);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  @override
Future<Either<Failure, RegisterModel>> register({
  required String name,
  required String email,
  required String password,
}) async {
  try {
    final response = await apiService.post(
      endPoint: '/auth/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    // اطبع شكل الريسبونس الكامل
    log('📥 Full Register Response: ${response.toString()}');
    log('📦 Register Response Data: ${response.data}');

    // هنا لو عايز تطبع شكل الـ JSON بطريقة منظمة:
    if (response.data is Map<String, dynamic>) {
      final json = response.data as Map<String, dynamic>;
      log('✅ Data Keys: ${json.keys}');
    }

    final registerModel = RegisterModel.fromJson(response.data);
    return right(registerModel);
  } on DioException catch (e) {
    log('❌ DioException: ${e.response?.data}');
    return left(ServerFailure.fromDioError(e));
  } catch (e, stack) {
    log('❌ General Error: $e');
    log('📌 Stacktrace: $stack');
    return left(ServerFailure(e.toString()));
  }
}


}
