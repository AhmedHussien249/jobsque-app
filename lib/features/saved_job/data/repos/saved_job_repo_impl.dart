import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/features/home/data/models/jobs_model.dart';
import 'package:jobsque/features/saved_job/data/repos/saved_repo.dart';

class SavedJobRepoImpl implements SavedJobRepo {
  final AppPreferences appPreferences;

  SavedJobRepoImpl(this.appPreferences);

  @override
  Future<Either<Failure, List<JobModel>>> getSavedJobs() async {
    try {
      final jobsStringList = appPreferences.getSavedJobsRaw();
      final jobs = jobsStringList
          .map((jobString) => JobModel.fromJson(jsonDecode(jobString)))
          .toList();
      return Right(jobs);
    } catch (e) {
      return Left(ServerFailure("Failed to load saved jobs: $e"));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleSavedJob(JobModel job) async {
    try {
      final jobsStringList = appPreferences.getSavedJobsRaw();

      final jobString = jsonEncode(job.toJson());

      if (jobsStringList.contains(jobString)) {
        jobsStringList.remove(jobString);
      } else {
        jobsStringList.add(jobString);
      }

      await appPreferences.setSavedJobsRaw(jobsStringList);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure("Failed to save job: $e"));
    }
  }

  @override
  Future<Either<Failure, bool>> isSaved(JobModel job) async {
    try {
      final jobsStringList = appPreferences.getSavedJobsRaw();
      final jobString = jsonEncode(job.toJson());
      return Right(jobsStringList.contains(jobString));
    } catch (e) {
      return Left(ServerFailure("Failed to check saved job: $e"));
    }
  }
}
