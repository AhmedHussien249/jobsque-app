import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/api_service.dart';
import 'package:jobsque/features/auth/data/repos/auth_repo.dart';
import 'package:jobsque/features/auth/data/repos/auth_repo_impl.dart';
import 'package:jobsque/features/auth/presentation/view_model/cubits/login_cubit/login_cubit.dart';
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

  // LoginCubit
  sl.registerFactory(() => LoginCubit(sl()));
}
