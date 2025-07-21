import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/features/auth/data/models/register_model.dart';
import 'package:jobsque/features/auth/data/repos/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;

  RegisterCubit(this.authRepo) : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    final result = await authRepo.register(
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(RegisterFailure(failure.errorMessage)),
      (registerModel) => emit(RegisterSuccess(registerModel)),
    );
  }
}
