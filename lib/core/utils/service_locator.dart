import 'package:get_it/get_it.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => AppPreferences(sl()));
}
