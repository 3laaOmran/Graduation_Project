part of 'login_cubit.dart';

@immutable
sealed class LoginStates {}

final class LoginInitialState extends LoginStates {}

final class LoginLoadingState extends LoginStates {}

final class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

final class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}
final class LoginUnauthorizedState extends LoginStates {
  final String error;

  LoginUnauthorizedState(this.error);
}
final class PhoneForgetPasswordLoadingState extends LoginStates {}

final class PhoneForgetPasswordSuccessState extends LoginStates {
  final LoginModel loginModel;

  PhoneForgetPasswordSuccessState(this.loginModel);
}

final class PhoneForgetPasswordErrorState extends LoginStates {
  final String error;

  PhoneForgetPasswordErrorState(this.error);
}
final class ConfirmPhoneNumberLoadingState extends LoginStates {}

final class ConfirmPhoneNumberSuccessState extends LoginStates {
  final ConfirmPhoneModel confirmPhoneModel;

  ConfirmPhoneNumberSuccessState(this.confirmPhoneModel);
}

final class ConfirmPhoneNumberErrorState extends LoginStates {
  final String error;

  ConfirmPhoneNumberErrorState(this.error);
}
final class ChangePasswordLoadingState extends LoginStates {}

final class ChangePasswordSuccessState extends LoginStates {
  final ConfirmPhoneModel confirmPhoneModel;

  ChangePasswordSuccessState(this.confirmPhoneModel);
}

final class ChangePasswordErrorState extends LoginStates {
  final String error;

  ChangePasswordErrorState(this.error);
}
final class LoginChangePasswordVisibilityState extends LoginStates {}
