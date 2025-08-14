import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/features/job_detail/data/repos/job_detail_repo.dart';
import 'job_detail_state.dart';

class JobDetailCubit extends Cubit<JobDetailState> {
  final JobDetailRepo jobDetailRepo;

  JobDetailCubit(this.jobDetailRepo) : super(JobDetailInitial());

  Future<void> fetchJobDetail(int id) async {
    emit(JobDetailLoading());
    final result = await jobDetailRepo.getJobDetail(id);
    result.fold(
      (failure) => emit(JobDetailFailure(failure.errorMessage)),
      (jobDetail) => emit(JobDetailSuccess(jobDetail)),
    );
  }
}
