// lib/features/show_apply_job/data/repos/show_applied_job_repo_impl.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/core/utils/api_service.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/service_locator.dart';
import 'package:jobsque/features/show_apply_job/data/models/show_applied_job_model.dart';
import 'package:jobsque/features/show_apply_job/data/repos/applied_job_repo.dart';

class ShowAppliedJobRepoImpl implements ShowAppliedJobRepo {
  final ApiService apiService;

  ShowAppliedJobRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<AppliedJobModel>>> fetchAppliedJobsForCurrentUser() async {
    try {
      // هجيب ايميل اليوزر الحالي من الـ preferences
      final currentEmail = sl<AppPreferences>().getUserEmail();
      if (currentEmail == null || currentEmail.isEmpty) {
        return left(ServerFailure('No logged-in user email found.'));
      }

      // NOTE: لو عندك endpoint مختلف حطه هنا. أغلب الحالات بيكون "/apply"
      final response = await apiService.get(endPoint: "/apply/1");

      final raw = response.data;
      if (raw == null || raw['status'] != true || raw['data'] == null) {
        return left(ServerFailure('Empty or invalid response from server.'));
      }

      final List dataList = raw['data'] as List;

      // parse
      final allJobs = dataList
          .whereType<Map<String, dynamic>>()
          .map((e) => AppliedJobModel.fromJson(e))
          .toList();

      // فلترة بالـ email (case-insensitive)
      final meOnly = allJobs.where((j) {
        final jobEmail = (j.email ?? '').trim().toLowerCase();
        return jobEmail == currentEmail.trim().toLowerCase();
      }).toList();

      return right(meOnly);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
