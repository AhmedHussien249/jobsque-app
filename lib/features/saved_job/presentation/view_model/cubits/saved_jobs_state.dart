import 'package:equatable/equatable.dart';
import 'package:jobsque/features/home/data/models/jobs_model.dart';

abstract class SavedJobsState extends Equatable {
  const SavedJobsState();

  @override
  List<Object?> get props => [];
}

class SavedJobsInitial extends SavedJobsState {}

class SavedJobsLoading extends SavedJobsState {}

class SavedJobsLoaded extends SavedJobsState {
  final List<JobModel> jobs;
  const SavedJobsLoaded(this.jobs);

  @override
  List<Object?> get props => [jobs];
}

class SavedJobsError extends SavedJobsState {
  final String message;
  const SavedJobsError(this.message);

  @override
  List<Object?> get props => [message];
}

class SavedJobStatus extends SavedJobsState {
  final bool isSaved;
  const SavedJobStatus(this.isSaved);

  @override
  List<Object?> get props => [isSaved];
}
