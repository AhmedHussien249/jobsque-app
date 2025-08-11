import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/features/home/data/repos/home_repo.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/job_state.dart';

class JobsCubit extends Cubit<JobsState> {
  final HomeRepo homeRepo;

  JobsCubit(this.homeRepo) : super(JobsInitial());

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
    emit(JobsLoading());
    final result = await homeRepo.searchJobs(name);
    result.fold(
      (failure) => emit(JobsFailure(failure.errorMessage)),
      (jobs) => emit(JobsSuccess(jobs)),
    );
  }

  void filterJobs({String? name, String? location, String? salary}) async {
    emit(JobsLoading());
    final result = await homeRepo.filterJobs(
      name: name,
      location: location,
      salary: salary,
    );
    result.fold(
      (failure) => emit(JobsFailure(failure.errorMessage)),
      (jobs) => emit(JobsSuccess(jobs)),
    );
  }
}
