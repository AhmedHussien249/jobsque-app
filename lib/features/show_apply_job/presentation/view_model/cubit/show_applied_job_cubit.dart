// lib/features/show_apply_job/presentation/view_model/cubit/show_applied_job_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/features/show_apply_job/data/repos/applied_job_repo.dart';
import 'show_applied_job_state.dart';

class ShowAppliedJobCubit extends Cubit<ShowAppliedJobState> {
  final ShowAppliedJobRepo repo;

  ShowAppliedJobCubit(this.repo) : super(ShowAppliedJobInitial());

  Future<void> getAppliedJobs() async {
    emit(ShowAppliedJobLoading());
    final result = await repo.fetchAppliedJobsForCurrentUser();

    result.fold(
      (failure) => emit(ShowAppliedJobFailure(failure.errorMessage)),
      (jobs) => emit(ShowAppliedJobSuccess(jobs)),
    );
  }
}
