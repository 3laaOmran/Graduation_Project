part of 'seller_signup_cubit.dart';

@immutable
sealed class SellerSignupStates {}

final class SellerSignupInitialState extends SellerSignupStates {}

final class SellerSignupLoadingState extends SellerSignupStates {}

final class SellerSignupSuccessState extends SellerSignupStates {
  final SignupModel signupModel;

  SellerSignupSuccessState(this.signupModel);
}

final class SellerSignupErrorState extends SellerSignupStates {
  final String error;

  SellerSignupErrorState(this.error);
}

final class SellerSignupUsedEmailOrPhoneErrorState extends SellerSignupStates {
  final String error;

  SellerSignupUsedEmailOrPhoneErrorState(this.error);
}
final class SellerVerificationLoadingState extends SellerSignupStates {}

final class SellerVerificationSuccessState extends SellerSignupStates {
  final VerificationModel verificationModel;

  SellerVerificationSuccessState(this.verificationModel);
}

final class SellerVerificationErrorState extends SellerSignupStates {
  final String error;

  SellerVerificationErrorState(this.error);
}

final class SellerVerificationOtpErrorState extends SellerSignupStates {
  final String error;

  SellerVerificationOtpErrorState(this.error);
}
final class SellerPhotoAndAddressLoadingState extends SellerSignupStates {}

final class SellerPhotoAndAddressSuccessState extends SellerSignupStates {
  final PhotoAndAddressModel photoAndAddressModel;

  SellerPhotoAndAddressSuccessState(this.photoAndAddressModel);
}

final class SellerPhotoAndAddressErrorState extends SellerSignupStates {
  final String error;

  SellerPhotoAndAddressErrorState(this.error);
}
final class SellerCertificatesLoadingState extends SellerSignupStates {}

final class SellerCertificatesSuccessState extends SellerSignupStates {
  final CertificatesModel certificatesModel;

  SellerCertificatesSuccessState(this.certificatesModel);
}

final class SellerCertificatesErrorState extends SellerSignupStates {
  final String error;

  SellerCertificatesErrorState(this.error);
}
final class GetGoverniratesLoadingState extends SellerSignupStates {}

final class GetGoverniratesSuccessState extends SellerSignupStates {
  // final GovernoratesModel governoratesModel;

  // GetGoverniratesSuccessState(this.governoratesModel);
}

final class GetGoverniratesErrorState extends SellerSignupStates {
  final String error;

  GetGoverniratesErrorState(this.error);
}
final class GetCitiesLoadingState extends SellerSignupStates {}

final class GetCitiesSuccessState extends SellerSignupStates {
  // final GovernoratesModel governoratesModel;

  // GetGoverniratesSuccessState(this.governoratesModel);
}

final class GetCitiesErrorState extends SellerSignupStates {
  final String error;

  GetCitiesErrorState(this.error);
}

final class SiginupChangePasswordVisibilityState extends SellerSignupStates {}

final class SignupPickImageState extends SellerSignupStates {}
final class SignupCommercialLicenseState extends SellerSignupStates {}
final class SignupHealthCertificateState extends SellerSignupStates {}
