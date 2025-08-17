// lib/features/show_apply_job/presentation/view_model/cubit/show_applied_job_state.dart
import 'package:equatable/equatable.dart';
import 'package:jobsque/features/show_apply_job/data/models/show_applied_job_model.dart';

abstract class ShowAppliedJobState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowAppliedJobInitial extends ShowAppliedJobState {}

class ShowAppliedJobLoading extends ShowAppliedJobState {}

class ShowAppliedJobFailure extends ShowAppliedJobState {
  final String error;
  ShowAppliedJobFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ShowAppliedJobSuccess extends ShowAppliedJobState {
  final List<AppliedJobModel> jobs;
  ShowAppliedJobSuccess(this.jobs);

  @override
  List<Object?> get props => [jobs];
}
