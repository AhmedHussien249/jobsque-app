import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/errors/failure.dart';
import 'package:jobsque/features/home/data/models/jobs_model.dart';
import 'package:jobsque/features/saved_job/data/repos/saved_repo.dart';

import 'saved_jobs_state.dart';

class SavedJobsCubit extends Cubit<SavedJobsState> {
  final SavedJobRepo savedRepo;

  SavedJobsCubit(this.savedRepo) : super(SavedJobsInitial());

  Future<void> loadSavedJobs() async {
    emit(SavedJobsLoading());
    final result = await savedRepo.getSavedJobs();
    result.fold(
      (failure) => emit(SavedJobsError(_mapFailure(failure))),
      (jobs) => emit(SavedJobsLoaded(jobs)),
    );
  }

  Future<void> toggleJob(JobModel job) async {
    final result = await savedRepo.toggleSavedJob(job);
    result.fold(
      (failure) => emit(SavedJobsError(_mapFailure(failure))),
      (_) => loadSavedJobs(),
    );
  }

  Future<void> checkIfSaved(JobModel job) async {
    final result = await savedRepo.isSaved(job);
    result.fold(
      (failure) => emit(SavedJobsError(_mapFailure(failure))),
      (isSaved) => emit(SavedJobStatus(isSaved)),
    );
  }

  String _mapFailure(Failure failure) {
    return failure.errorMessage;
  }
}
