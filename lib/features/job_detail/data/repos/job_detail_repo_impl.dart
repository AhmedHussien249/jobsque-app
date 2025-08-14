import 'package:dartz/dartz.dart';
import 'package:jobsque/core/errors/failure.dart';

import '../../../../core/utils/api_service.dart';
import '../models/job_detail_model.dart';
import 'job_detail_repo.dart';

class JobDetailRepoImpl implements JobDetailRepo {
  final ApiService apiService;

  JobDetailRepoImpl(this.apiService);

  @override
  Future<Either<Failure, JobDetailModel>> getJobDetail(int id) async {
    try {
      final response = await apiService.get(endPoint: '/jobs/$id');
      return Right(JobDetailModel.fromJson(response.data['data']));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
