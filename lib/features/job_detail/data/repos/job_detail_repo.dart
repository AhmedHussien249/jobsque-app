import 'package:dartz/dartz.dart';
import 'package:jobsque/core/errors/failure.dart';
import '../models/job_detail_model.dart';

abstract class JobDetailRepo {
  Future<Either<Failure, JobDetailModel>> getJobDetail(int id);
}
