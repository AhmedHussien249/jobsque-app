import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobsque/core/observer/app_bloc_observer.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/core/utils/service_locator.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/job_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  Bloc.observer = AppBlocObserver();
 runApp(
    BlocProvider(
      create: (_) => sl<JobsCubit>()..fetchAllJobs(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp.router(
        title: 'Jobsque',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue,scaffoldBackgroundColor: Colors.white,),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
