import 'package:go_router/go_router.dart';
import 'package:jobsque/features/auth/presentation/views/check_your_email_view.dart';
import 'package:jobsque/features/auth/presentation/views/create_new_password_view.dart';
import 'package:jobsque/features/auth/presentation/views/forget_password_view.dart';
import 'package:jobsque/features/auth/presentation/views/password_changed_view.dart';
import 'package:jobsque/features/auth/presentation/views/login_view.dart';
import 'package:jobsque/features/intro/presentation/views/on_boarding_view.dart';
import 'package:jobsque/features/intro/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kOnBoardingView = '/onBoardingView';
  static const kLoginView = '/loginView';
  static const kForgetPasswordView = '/forgetPasswordView';
  static const kCheckYourEmailView = '/checkYourEmailView';
  static const kCreateNewPasswordView = '/createNewPasswordView';
  static const kPasswordChangedView = '/passwordChangedView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashView()),
      GoRoute(
        path: kOnBoardingView,
        builder: (context, state) => OnBoardingView(),
      ),
      GoRoute(path: kLoginView, builder: (context, state) => LoginView()),
      GoRoute(
        path: kForgetPasswordView,
        builder: (context, state) => ForgetPasswordView(),
      ),
      GoRoute(
        path: kCheckYourEmailView,
        builder: (context, state) => CheckYourEmailView(),
      ),
      GoRoute(
        path: kCreateNewPasswordView,
        builder: (context, state) => CreateNewPasswordView(),
      ),
      GoRoute(
        path: kPasswordChangedView,
        builder: (context, state) => PasswordChangedView(),
      ),
    ],
  );
}
