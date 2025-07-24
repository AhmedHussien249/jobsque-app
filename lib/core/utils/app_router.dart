import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/service_locator.dart';
import 'package:jobsque/features/auth/presentation/view_model/cubits/login_cubit/login_cubit.dart';
import 'package:jobsque/features/auth/presentation/views/check_your_email_view.dart';
import 'package:jobsque/features/auth/presentation/views/create_account_customization_view.dart';
import 'package:jobsque/features/auth/presentation/views/create_account_view.dart';
import 'package:jobsque/features/auth/presentation/views/create_new_password_view.dart';
import 'package:jobsque/features/auth/presentation/views/forget_password_view.dart';
import 'package:jobsque/features/auth/presentation/views/login_view.dart';
import 'package:jobsque/features/auth/presentation/views/password_changed_view.dart';
import 'package:jobsque/features/auth/presentation/views/prefered_location_view.dart';
import 'package:jobsque/features/auth/presentation/views/your_account_has_been_set_up.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/suggested_job_cubit.dart';
import 'package:jobsque/features/home/presentation/views/home_view.dart';
import 'package:jobsque/features/intro/presentation/views/on_boarding_view.dart';
import 'package:jobsque/features/intro/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kOnBoardingView = '/onBoardingView';
  static const kLoginView = '/loginView';
  static const kForgetPasswordView = '/forgetPasswordView';
  static const kCheckYourEmailView = '/checkYourEmailView';
  static const kCreateNewPasswordView = '/createNewPasswordView';
  static const kPasswordChangedView = '/passwordChangedView';
  static const kCreateAccountView = '/createAccountView';
  static const kCreateAccountCustomizationView =
      '/createAccountCustomizationView';
  static const kPreferedLocactionView = '/preferedLocactionView';
  static const kYourAccountHasBeenSetUp = '/yourAccountHasBeenSetUp';
  static const String kHomeView = '/home';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashView()),
      GoRoute(
        path: kOnBoardingView,
        builder: (context, state) => OnBoardingView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<LoginCubit>(),
          child: LoginView(),
        ),
      ),
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
      GoRoute(
        path: kCreateAccountView,
        builder: (context, state) => CreateAccountView(),
      ),
      GoRoute(
        path: kCreateAccountCustomizationView,
        builder: (context, state) => CreateAccountCustomizationView(),
      ),
      GoRoute(
        path: kPreferedLocactionView,
        builder: (context, state) => PreferedLocationView(),
      ),
      GoRoute(
        path: kYourAccountHasBeenSetUp,
        builder: (context, state) => YourAccountHasBeenSetUp(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<JobsCubit>()..fetchAllJobs(),
          child: const HomeView(),
        ),
      ),
    ],
  );
}
