part of 'siginup_cubit.dart';

@immutable
sealed class SignupStates {}

final class SignupInitialState extends SignupStates {}

final class SignupLoadingState extends SignupStates {}

final class SignupSuccessState extends SignupStates {
  final LoginModel loginModel;

  SignupSuccessState(this.loginModel);
}

final class SignupErrorState extends SignupStates {
  final String error;

  SignupErrorState(this.error);
}

final class SiginupChangePasswordVisibilityState extends SignupStates {}

final class SignupPickImageState extends SignupStates {}
