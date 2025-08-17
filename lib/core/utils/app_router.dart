import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/service_locator.dart';
import 'package:jobsque/features/apply_job/presentation/view_model/cubit/apply_job_cubit.dart';
import 'package:jobsque/features/apply_job/presentation/views/apply_job_bio_data.dart';
import 'package:jobsque/features/apply_job/presentation/views/apply_job_type_of_work.dart';
import 'package:jobsque/features/apply_job/presentation/views/apply_job_upload_portfolio.dart';
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
import 'package:jobsque/features/home/presentation/views/home_view.dart';
import 'package:jobsque/features/home/presentation/views/search_view.dart';
import 'package:jobsque/features/intro/presentation/views/on_boarding_view.dart';
import 'package:jobsque/features/intro/presentation/views/splash_view.dart';
import 'package:jobsque/features/job_detail/presentation/view_model/cubits/job_detail_cubit.dart';
import 'package:jobsque/features/job_detail/presentation/views/job_detail_view.dart';

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
  static const String kSearchView = '/searchview';
  static const String kJobDetailView = '/jobDetailView';
  static const String kApplyJobBioData = '/applyJobBioData';
  static const String kApplyTypeOfWork = '/applyJobTypeOfWork';
  static const String kApplyJobUploadPortfolio = '/applyJobUploadPortfolio';

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
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      GoRoute(
        path: AppRouter.kSearchView,
        builder: (context, state) => SearchView(
          appPreferences: sl<AppPreferences>(),
        ), // بلا BlocProvider هنا كمان
      ),
      GoRoute(
        path: '$kJobDetailView/:id',
        builder: (context, state) {
          final jobId = int.parse(state.pathParameters['id']!);
           final jobType = state.uri.queryParameters['jobType'] ?? "";

          return BlocProvider(
            create: (context) => sl<JobDetailCubit>()..fetchJobDetail(jobId),
            child: JobDetailView(jobId: jobId,jobType: jobType ,),
          );
        },
      ),

      GoRoute(
  path: kApplyJobBioData,
  builder: (context, state) {
    final jobId = int.parse(state.uri.queryParameters['jobId']!);
    final jobType = state.uri.queryParameters['jobType']!;
    return ApplyJobBiodata(jobId: jobId, jobType: jobType);
  },
),

      GoRoute(
        path: kApplyTypeOfWork,
        builder: (context, state) {
          final jobId = int.parse(state.uri.queryParameters['jobId']!);
          final name = state.uri.queryParameters['name']!;
          final email = state.uri.queryParameters['email']!;
          final mobile = state.uri.queryParameters['mobile']!;
          return ApplyJobTypeOfWork(
             jobType: state.uri.queryParameters['jobType']!,
            jobId: jobId,
            name: name,
            email: email,
            mobile: mobile,
          );
        },
      ),

      GoRoute(
        path: kApplyJobUploadPortfolio,
        builder: (context, state) {
          final jobId = int.parse(state.uri.queryParameters['jobId']!);
          final name = state.uri.queryParameters['name']!;
          final email = state.uri.queryParameters['email']!;
          final mobile = state.uri.queryParameters['mobile']!;
          final workType = state.uri.queryParameters['workType']!;
          return BlocProvider(
            create: (context) => sl<ApplyJobCubit>(),
            child: ApplyJobUploadPortfolio(
              jobId: jobId,
              name: name,
              email: email,
              mobile: mobile,
              workType: workType,
            ),
          );
        },
      ),
    ],
  );
}
