part of 'seller_login_cubit.dart';

@immutable
sealed class SellerLoginStates {}



final class SellerLoginInitialState extends SellerLoginStates {}

final class SellerLoginLoadingState extends SellerLoginStates {}

final class SellerLoginSuccessState extends SellerLoginStates {
  final LoginModel loginModel;

  SellerLoginSuccessState(this.loginModel);
}

final class SellerLoginErrorState extends SellerLoginStates {
  final String error;

  SellerLoginErrorState(this.error);
}

final class SellerLoginUnauthorizedState extends SellerLoginStates {
  final String error;

  SellerLoginUnauthorizedState(this.error);
}

final class PhoneForgetPasswordLoadingState extends SellerLoginStates {}

final class PhoneForgetPasswordSuccessState extends SellerLoginStates {
  final LoginModel loginModel;

  PhoneForgetPasswordSuccessState(this.loginModel);
}

final class PhoneForgetPasswordErrorState extends SellerLoginStates {
  final String error;

  PhoneForgetPasswordErrorState(this.error);
}
final class ConfirmPhoneNumberLoadingState extends SellerLoginStates {}

final class ConfirmPhoneNumberSuccessState extends SellerLoginStates {
  final ConfirmPhoneModel confirmPhoneModel;

  ConfirmPhoneNumberSuccessState(this.confirmPhoneModel);
}

final class ConfirmPhoneNumberErrorState extends SellerLoginStates {
  final String error;

  ConfirmPhoneNumberErrorState(this.error);
}
final class ChangePasswordLoadingState extends SellerLoginStates {}

final class ChangePasswordSuccessState extends SellerLoginStates {
  final ConfirmPhoneModel confirmPhoneModel;

  ChangePasswordSuccessState(this.confirmPhoneModel);
}

final class ChangePasswordErrorState extends SellerLoginStates {
  final String error;

  ChangePasswordErrorState(this.error);
}
final class SellerLoginChangePasswordVisibilityState extends SellerLoginStates {}
