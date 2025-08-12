import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/api_service.dart';
import 'package:jobsque/features/auth/data/repos/auth_repo.dart';
import 'package:jobsque/features/auth/data/repos/auth_repo_impl.dart';
import 'package:jobsque/features/auth/presentation/view_model/cubits/login_cubit/login_cubit.dart';
import 'package:jobsque/features/auth/presentation/view_model/cubits/register_cubit/register_cubit.dart';
import 'package:jobsque/features/home/data/repos/home_repo.dart';
import 'package:jobsque/features/home/data/repos/home_repo_impl.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/job_cubit.dart';
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
   sl.registerFactory(() => JobsCubit(
    sl<HomeRepo>(),
    sl<AppPreferences>(),  // لازم تمرر AppPreferences هنا
  ));

}
