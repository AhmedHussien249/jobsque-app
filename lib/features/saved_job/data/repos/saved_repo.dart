import 'package:dartz/dartz.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/features/home/data/models/jobs_model.dart';

abstract class SavedJobRepo {
  Future<Either<Failure, List<JobModel>>> getSavedJobs();
  Future<Either<Failure, Unit>> toggleSavedJob(JobModel job);
  Future<Either<Failure, bool>> isSaved(JobModel job);
}
