// lib/features/show_apply_job/data/repos/show_applied_job_repo.dart
import 'package:dartz/dartz.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/features/show_apply_job/data/models/show_applied_job_model.dart';

abstract class ShowAppliedJobRepo {
  Future<Either<Failure, List<AppliedJobModel>>>
  fetchAppliedJobsForCurrentUser();
}
