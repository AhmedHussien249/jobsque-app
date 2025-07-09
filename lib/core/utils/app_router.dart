import 'package:go_router/go_router.dart';
import 'package:jobsque/features/auth/login/views/login_view.dart';
import 'package:jobsque/features/intro/presentation/on_boarding/views/on_boarding_view.dart';
import 'package:jobsque/features/intro/presentation/splash/views/splash_view.dart';

abstract class AppRouter {
  static const kOnBoardingView = '/onBoardingView';
  static const kLoginView = '/loginView';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashView()),
      GoRoute(
        path: kOnBoardingView,
        builder: (context, state) => OnBoardingView(),
      ),
      GoRoute(path: kLoginView, builder: (context, state) => LoginView()),
    ],
  );
}
