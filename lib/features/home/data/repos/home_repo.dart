import 'package:dartz/dartz.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/features/home/data/models/jobs_model.dart';

abstract class HomeRepo {
  Future<Either<ServerFailure, List<JobModel>>> getAllJobs();
}
