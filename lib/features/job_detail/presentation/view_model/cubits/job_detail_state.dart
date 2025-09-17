import 'package:jobsque/features/job_detail/data/models/job_detail_model.dart';

abstract class JobDetailState {}

class JobDetailInitial extends JobDetailState {}

class JobDetailLoading extends JobDetailState {}

class JobDetailSuccess extends JobDetailState {
  final JobDetailModel jobDetail;
  JobDetailSuccess(this.jobDetail);
}

class JobDetailFailure extends JobDetailState {
  final String error;
  JobDetailFailure(this.error);
}
