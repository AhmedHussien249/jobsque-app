import 'package:dartz/dartz.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/features/home/data/models/jobs_model.dart';

abstract class HomeRepo {
  Future<Either<ServerFailure, List<JobModel>>> getAllJobs();
  Future<Either<ServerFailure, List<JobModel>>> searchJobs(String name);
  Future<Either<ServerFailure, List<JobModel>>> filterJobs({
    String? name,
    String? location,
    String? salary,
    Set<String>? jobTimeTypes,
  });
}
