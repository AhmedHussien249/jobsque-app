import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/service_locator.dart';
import 'package:jobsque/features/auth/data/models/user_model.dart';
import 'package:jobsque/features/auth/data/repos/auth_repo.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe
  }) async {
    emit(LoginLoading());

    final result = await authRepo.login(email: email, password: password);

    result.fold(
      (failure) => emit(LoginFailure(failure.errorMessage)),
       (user) async {
        // ✅ Save token to SharedPreferences
        final prefs = sl<AppPreferences>();

        if (rememberMe) {
          await prefs.setToken(user.token);
          await prefs.setRememberMe(true);
          await prefs.setLoggedIn(true);
          await prefs.setUserEmail(user.email);
          await prefs.setUserName(user.name);
        } else {
          await prefs.setRememberMe(false);
          await prefs.clearAll();
        }

        emit(LoginSuccess(user));
      },
    );
  }
}
