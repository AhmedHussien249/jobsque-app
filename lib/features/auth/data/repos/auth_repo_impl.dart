import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/core/utils/api_service.dart';
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
}
