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
final class VerificationLoadingState extends SignupStates {}

final class VerificationSuccessState extends SignupStates {
  final VerificationModel verificationModel;

  VerificationSuccessState(this.verificationModel);
}

final class VerificationErrorState extends SignupStates {
  final String error;

  VerificationErrorState(this.error);
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

final class SiginupChangePasswordVisibilityState extends SignupStates {}

final class SignupPickImageState extends SignupStates {}
