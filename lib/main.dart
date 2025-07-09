import 'package:flutter/material.dart';
import 'package:joblink/core/utils/app_router.dart';
import 'package:joblink/core/utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'JobLink',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue,scaffoldBackgroundColor: Colors.white,),
      routerConfig: AppRouter.router,
    );
  }
}
