part of 'siginup_cubit.dart';

@immutable
sealed class SignupStates {}

final class SignupInitialState extends SignupStates {}

final class SignupLoadingState extends SignupStates {}

final class SignupSuccessState extends SignupStates {
  final SignupModel signupModel;

  SignupSuccessState(this.signupModel);
}

final class SignupErrorState extends SignupStates {
  final String error;

  SignupErrorState(this.error);
}

final class SignupUsedEmailOrPhoneErrorState extends SignupStates {
  final String error;

  SignupUsedEmailOrPhoneErrorState(this.error);
}
final class VerificationLoadingState extends SignupStates {}

final class VerificationSuccessState extends SignupStates {
  final VerificationModel verificationModel;

  VerificationSuccessState(this.verificationModel);
}

final class VerificationErrorState extends SignupStates {
  final String error;

  VerificationErrorState(this.error);
}
final class VerificationOtpErrorState extends SignupStates {
  final String error;

  VerificationOtpErrorState(this.error);
}
final class PhotoAndAddressLoadingState extends SignupStates {}

final class PhotoAndAddressSuccessState extends SignupStates {
  final PhotoAndAddressModel photoAndAddressModel;

  PhotoAndAddressSuccessState(this.photoAndAddressModel);
}

final class PhotoAndAddressErrorState extends SignupStates {
  final String error;

  PhotoAndAddressErrorState(this.error);
}
final class GetGoverniratesLoadingState extends SignupStates {}

final class GetGoverniratesSuccessState extends SignupStates {
  // final GovernoratesModel governoratesModel;

  // GetGoverniratesSuccessState(this.governoratesModel);
}

final class GetGoverniratesErrorState extends SignupStates {
  final String error;

  GetGoverniratesErrorState(this.error);
}
final class GetCitiesLoadingState extends SignupStates {}

final class GetCitiesSuccessState extends SignupStates {
  // final GovernoratesModel governoratesModel;

  // GetGoverniratesSuccessState(this.governoratesModel);
}

final class GetCitiesErrorState extends SignupStates {
  final String error;

  GetCitiesErrorState(this.error);
}

final class SiginupChangePasswordVisibilityState extends SignupStates {}

final class SignupPickImageState extends SignupStates {}
