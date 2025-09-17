import 'package:dartz/dartz.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/features/auth/data/models/register_model.dart';
import 'package:jobsque/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, RegisterModel>> register({
    required String name,
    required String email,
    required String password,
  });
}
