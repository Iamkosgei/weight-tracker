part of 'login_user_cubit.dart';

abstract class LoginUserState extends Equatable {
  const LoginUserState();

  @override
  List<Object> get props => [];
}

class LoginUserInitial extends LoginUserState {}

class LoginUserLoading extends LoginUserState {}

class LoginUserSuccess extends LoginUserState {}

class LoginUserError extends LoginUserState {
  final String error;

  const LoginUserError(this.error);
}
