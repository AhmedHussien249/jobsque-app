import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/api_service.dart';
import 'package:jobsque/features/apply_job/data/repos/apply_jobs_repo.dart';
import 'package:jobsque/features/apply_job/data/repos/apply_jobs_repo_impl.dart';
import 'package:jobsque/features/apply_job/presentation/view_model/cubit/apply_job_cubit.dart';
import 'package:jobsque/features/auth/data/repos/auth_repo.dart';
import 'package:jobsque/features/auth/data/repos/auth_repo_impl.dart';
import 'package:jobsque/features/auth/presentation/view_model/cubits/login_cubit/login_cubit.dart';
import 'package:jobsque/features/auth/presentation/view_model/cubits/register_cubit/register_cubit.dart';
import 'package:jobsque/features/home/data/repos/home_repo.dart';
import 'package:jobsque/features/home/data/repos/home_repo_impl.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/job_cubit.dart';
import 'package:jobsque/features/job_detail/data/repos/job_detail_repo.dart';
import 'package:jobsque/features/job_detail/data/repos/job_detail_repo_impl.dart';
import 'package:jobsque/features/job_detail/presentation/view_model/cubits/job_detail_cubit.dart';
import 'package:jobsque/features/profile/data/repos/profile_repo.dart';
import 'package:jobsque/features/profile/data/repos/profile_repo_impl.dart';
import 'package:jobsque/features/profile/presentation/view_model/cubits/edit_profile_cubit/profile_cubit.dart';
import 'package:jobsque/features/saved_job/data/repos/saved_job_repo_impl.dart';
import 'package:jobsque/features/saved_job/data/repos/saved_repo.dart';
import 'package:jobsque/features/saved_job/presentation/view_model/cubits/saved_jobs_cubit.dart';
import 'package:jobsque/features/show_apply_job/data/repos/applied_job_repo.dart';
import 'package:jobsque/features/show_apply_job/data/repos/applied_job_repo_impl.dart';
import 'package:jobsque/features/show_apply_job/presentation/view_model/cubit/show_applied_job_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => AppPreferences(sl()));

  // Dio
  sl.registerLazySingleton(() => Dio());

  // ApiService
  sl.registerLazySingleton(() => ApiService(sl()));

  // AuthRepo
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()));

  // HomeRepo
  sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(sl()));

  // LoginCubit
  sl.registerFactory(() => LoginCubit(sl()));

  // RegisterCubit
  sl.registerFactory(() => RegisterCubit(sl()));

  // SuggestedJobCubit
  sl.registerFactory(
    () => JobsCubit(
      sl<HomeRepo>(),
      sl<AppPreferences>(), // لازم تمرر AppPreferences هنا
    ),
  );

  // JobDetailRepo
  sl.registerLazySingleton<JobDetailRepo>(
    () => JobDetailRepoImpl(sl<ApiService>()),
  );

  // JobDetailCubit
  sl.registerFactory<JobDetailCubit>(() => JobDetailCubit(sl<JobDetailRepo>()));

  // ApplyJobRepo
  sl.registerLazySingleton<ApplyJobsRepo>(
    () => ApplyJobsRepoImpl(sl<ApiService>()),
  );

  // ApplyJobCubit
  sl.registerFactory<ApplyJobCubit>(() => ApplyJobCubit(sl<ApplyJobsRepo>()));

  sl.registerLazySingleton<ShowAppliedJobRepo>(
    () => ShowAppliedJobRepoImpl(sl<ApiService>()),
  );

// ShowAppliedJobCubit
sl.registerFactory(
  () => ShowAppliedJobCubit(sl<ShowAppliedJobRepo>()),
);

// SavedJobRepo
sl.registerLazySingleton<SavedJobRepo>(
  () => SavedJobRepoImpl(sl<AppPreferences>()),
);

// SavedJobsCubit
sl.registerFactory(
  () => SavedJobsCubit(sl<SavedJobRepo>()),
);

// ProfileRepo
sl.registerLazySingleton<ProfileRepo>(
  () => ProfileRepoImpl(sl<ApiService>()),
);

// ProfileCubit
sl.registerFactory(
  () => ProfileCubit(sl<ProfileRepo>()),
);


}
