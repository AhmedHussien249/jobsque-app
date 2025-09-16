import 'package:dartz/dartz.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/features/apply_job/data/model/apply_job_model.dart';

abstract class ApplyJobsRepo {
  Future<Either<Failure, ApplyJobModel>> applyJob({
    required String cvFilePath,
    required String name,
    required String email,
    required String mobile,
    required String workType,
    String? otherFilePath,
    required int jobsId,
    required int userId,
    bool isUpdate = false, // Flag to indicate overwrite
  });
}
