import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/features/apply_job/data/repos/apply_jobs_repo.dart';
import 'package:jobsque/features/apply_job/presentation/view_model/cubit/apply_job_state.dart';

class ApplyJobCubit extends Cubit<ApplyJobState> {
  final ApplyJobsRepo applyJobsRepo;

  ApplyJobCubit(this.applyJobsRepo) : super(ApplyJobInitial());

  Future<void> applyJob({
    required String cvFilePath,
    required String name,
    required String email,
    required String mobile,
    required String workType,
    required String? otherFilePath,
    required int jobsId,
    required int userId,
  }) async {
    log("🌟 Submit button clicked");
    log("CV Path: $cvFilePath, Other File: ${otherFilePath ?? 'None'}");

    emit(ApplyJobLoading());
    log("⏳ State: Loading");

    final result = await applyJobsRepo.applyJob(
      cvFilePath: cvFilePath,
      name: name,
      email: email,
      mobile: mobile,
      workType: workType,
      otherFilePath: otherFilePath ?? "",
      jobsId: jobsId,
      userId: userId,
    );

    result.fold(
      (failure) {
        log("❌ ApplyJob failed: ${failure.errorMessage}");
        emit(ApplyJobFailure(failure.errorMessage));
      },
      (applyJob) {
        log("✅ ApplyJob succeeded: ${applyJob.toString()}");
        emit(ApplyJobSuccess(applyJob));
      },
    );
  }
}
