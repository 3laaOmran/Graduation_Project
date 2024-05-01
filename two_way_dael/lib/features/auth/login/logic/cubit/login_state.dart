part of 'login_cubit.dart';

@immutable
sealed class LoginStates {}

final class LoginInitialState extends LoginStates {}

final class LoginLoadingState extends LoginStates {}

final class LoginSuccessState extends LoginStates {
  // final LoginModel loginModel;

  // LoginSuccessState(this.loginModel);
}

final class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

final class LoginChangePasswordVisibilityState extends LoginStates {}
