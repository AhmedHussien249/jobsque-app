import 'package:jobsque/features/apply_job/data/model/apply_job_model.dart';

abstract class ApplyJobState {}

class ApplyJobInitial extends ApplyJobState {}

class ApplyJobLoading extends ApplyJobState {}

class ApplyJobSuccess extends ApplyJobState {
  final ApplyJobModel applyJob;

  ApplyJobSuccess(this.applyJob);
}

class ApplyJobFailure extends ApplyJobState {
  final String message;

  ApplyJobFailure(this.message);
}
