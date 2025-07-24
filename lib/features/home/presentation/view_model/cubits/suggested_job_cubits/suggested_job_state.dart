import 'package:equatable/equatable.dart';
import 'package:jobsque/features/home/data/models/jobs_model.dart';

abstract class JobsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class JobsInitial extends JobsState {}

class JobsLoading extends JobsState {}

class JobsSuccess extends JobsState {
  final List<JobModel> jobs;

  JobsSuccess(this.jobs);

  @override
  List<Object?> get props => [jobs];
}

class JobsFailure extends JobsState {
  final String error;

  JobsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
