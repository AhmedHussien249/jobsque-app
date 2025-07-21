part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterModel registerModel;

  const RegisterSuccess(this.registerModel);

  @override
  List<Object?> get props => [registerModel];
}

class RegisterFailure extends RegisterState {
  final String message;

  const RegisterFailure(this.message);

  @override
  List<Object?> get props => [message];
}
