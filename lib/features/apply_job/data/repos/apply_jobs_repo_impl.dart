import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/core/utils/api_service.dart';
import 'package:jobsque/features/apply_job/data/model/apply_job_model.dart';
import 'package:jobsque/features/apply_job/data/repos/apply_jobs_repo.dart';

class ApplyJobsRepoImpl implements ApplyJobsRepo {
  final ApiService apiService;

  ApplyJobsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ApplyJobModel>> applyJob({
    required String cvFilePath,
    required String name,
    required String email,
    required String mobile,
    required String workType,
    required String? otherFilePath,
    required int jobsId,
    required int userId,
  }) async {
    try {
      log("🚀 Applying for Job...");
      log("CV Path: $cvFilePath");
      log("Other File Path: ${otherFilePath ?? 'None'}");
      log("Name: $name, Email: $email, Mobile: $mobile, Work Type: $workType");
      log("Job ID: $jobsId, User ID: $userId");

     final cvFileName = cvFilePath.split('/').last.replaceAll(' ', '_').replaceAll('&', '_');
final otherFileName = otherFilePath?.split('/').last.replaceAll(' ', '_').replaceAll('&', '_') ?? "";

final formData = FormData.fromMap({
  "cv_file": await MultipartFile.fromFile(cvFilePath, filename: cvFileName),
  "name": name,
  "email": email,
  "mobile": mobile,
  "work_type": workType,
  "other_file": otherFilePath != null && otherFilePath.isNotEmpty
      ? await MultipartFile.fromFile(otherFilePath, filename: otherFileName)
      : MultipartFile.fromBytes([], filename: 'empty.txt'), // بدل null
  "jobs_id": jobsId,
  "user_id": userId,
});


      log("Form Data prepared: $formData");

      final response = await apiService.post(
        endPoint: '/apply',
        data: formData,
        useFormData: true,
      );

      log("✅ API Response received: ${response.data}");

      return right(ApplyJobModel.fromJson(response.data));
    } catch (e) {
      log("❌ Error while applying: $e");
      return left(ServerFailure(e.toString()));
    }
  }
}
