import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/core/utils/api_service.dart';
import 'package:jobsque/features/home/data/models/jobs_model.dart';
import 'package:jobsque/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);

  @override
  Future<Either<ServerFailure, List<JobModel>>> getAllJobs() async {
    try {
      final response = await apiService.get(endPoint: "/jobs");
      final jobsList = (response.data['data'] as List)
          .map((job) => JobModel.fromJson(job))
          .toList();

      log("✔️ Jobs fetched successfully: ${jobsList.length}");
      return Right(jobsList);
    } catch (e) {
      log("❌ Error fetching jobs: $e");
      return Left(ServerFailure(e.toString()));
    }
  }
}
