// jobs_cubit.dart

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/features/home/data/repos/home_repo.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/job_state.dart';

class JobsCubit extends Cubit<JobsState> {
  final HomeRepo homeRepo;
  final AppPreferences appPreferences;  // اضفت appPreferences هنا

  JobsCubit(this.homeRepo, this.appPreferences) : super(JobsInitial());

  void fetchAllJobs() async {
    emit(JobsLoading());
    final result = await homeRepo.getAllJobs();

    result.fold(
      (failure) {
        log("❌ Failed to load jobs: ${failure.errorMessage}");
        emit(JobsFailure(failure.errorMessage));
      },
      (jobs) {
        log("✔️ Loaded ${jobs.length} jobs");
        emit(JobsSuccess(jobs));
      },
    );
  }

  void searchJobs(String name) async {
    if (name.trim().isEmpty) {
      fetchAllJobs();
      return;
    }


    await appPreferences.addSearchQuery(name);

    emit(JobsLoading());
    final result = await homeRepo.searchJobs(name);
    result.fold(
      (failure) => emit(JobsFailure(failure.errorMessage)),
      (jobs) => emit(JobsSuccess(jobs)),
    );
  }

  void filterJobs({
    String? name,
    String? location,
    String? salary,
    Set<String>? jobTimeTypes,
  }) async {
    emit(JobsLoading());
    final result = await homeRepo.filterJobs(
      name: name,
      location: location,
      salary: salary,
      jobTimeTypes: jobTimeTypes,
    );
    result.fold(
      (failure) => emit(JobsFailure(failure.errorMessage)),
      (jobs) => emit(JobsSuccess(jobs)),
    );
  }
}
