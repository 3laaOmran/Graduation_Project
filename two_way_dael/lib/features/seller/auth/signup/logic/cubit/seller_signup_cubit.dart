import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:two_way_dael/core/networking/end_points.dart';
import 'package:two_way_dael/features/customer/auth/signup/data/models/signup_model.dart';
import '../../../../../../core/networking/dio_helper.dart';
import '../../../../../customer/auth/signup/data/models/get_gov_and_city_model.dart';

part 'seller_signup_state.dart';

class SellerSignupCubit extends Cubit<SellerSignupStates> {
  SellerSignupCubit() : super(SellerSignupInitialState());

  static SellerSignupCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final photoAndAddressFormKey = GlobalKey<FormState>();
  var otpController = TextEditingController();

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var governorateController = TextEditingController();
  var cityController = TextEditingController();
  var streetController = TextEditingController();

  SignupModel? signupModel;
  void userSignup({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(SellerSignupLoadingState());
    DioHelper.postData(
      url: sellerSignup,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      signupModel = SignupModel.fromJson(value.data);
      emit(SellerSignupSuccessState(signupModel!));
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 422) {
        final responseData = error.response!.data['data'];
        final phoneError = responseData['phone']?.first;
        final emailError = responseData['email']?.first;
        String errorMessage = '';

        if (phoneError != null && emailError == null) {
          errorMessage = phoneError;
        } else if (emailError != null && phoneError == null) {
          errorMessage = emailError;
        } else if (emailError != null && phoneError != null) {
          errorMessage = '$emailError \n $phoneError';
        }

        print('Error: $errorMessage');
        emit(SellerSignupUsedEmailOrPhoneErrorState(errorMessage));
      } else if (error is DioException && error.response?.statusCode == 429) {
        print('Unauthorized: ${error.response!.data['message']}');
        emit(SellerSignupUsedEmailOrPhoneErrorState(
            error.response!.data['message']));
      }
      debugPrint('errorState: ${error.toString()}');
      emit(SellerSignupErrorState(error.toString()));
    });
  }

  VerificationModel? verificationModel;
  void otpVerification({
    required String otp,
    required String token,
  }) {
    emit(SellerVerificationLoadingState());
    DioHelper.postData(
      token: token,
      url: sellerVerification,
      data: {
        'otp': otp,
      },
    ).then((value) {
      verificationModel = VerificationModel.fromJson(value.data);
      debugPrint(value.data['message']);
      emit(SellerVerificationSuccessState(verificationModel!));
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 422) {
        emit(SellerVerificationOtpErrorState(
            error.response!.data['data']['otp'][0]));
      } else if (error is DioException && error.response?.statusCode == 401) {
        emit(SellerVerificationOtpErrorState(error.response!.data['message']));
      }
      debugPrint(error.toString());
      emit(SellerVerificationErrorState(error.toString()));
    });
  }

  int? selectedGovernorateId;
  int? selectedCityId;
  PhotoAndAddressModel? photoAndAddressModel;
  void photoAndAddress({
    required int cityId,
    required int governorateId,
    required String street,
    required String token,
    required File? image,
  }) {
    emit(SellerPhotoAndAddressLoadingState());

    Map<String, dynamic> data = {
      'city_id': cityId,
      'governorate_id': governorateId,
      'street': street,
    };

    DioHelper.postData(
      token: token,
      url: sellerPhotoAndAddress,
      data: data,
      image: image,
    ).then((value) {
      photoAndAddressModel = PhotoAndAddressModel.fromJson(value.data);
      debugPrint(value.data['message']);
      emit(SellerPhotoAndAddressSuccessState(photoAndAddressModel!));
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 422) {
        emit(SellerPhotoAndAddressErrorState(
            error.response!.data['data']['image'][0]));
      }
      debugPrint(error.toString());
      // emit(SellerPhotoAndAddressErrorState(error.toString()));
    });
  }

  CertificatesModel? certificatesModel;

  void certificates({
    required String token,
    required File? healthCertificate,
    required File? commercialLicense,
  }) {
    emit(SellerCertificatesLoadingState());

    DioHelper.postCertificates(
      token: token,
      url: sellerCertificates,
      data: {},
      healthApprovalCertificate:healthCertificate,
      commercialRestaurantLicenses: commercialLicense,
    ).then((value) {
      certificatesModel = CertificatesModel.fromJson(value.data);
      emit(SellerCertificatesSuccessState(certificatesModel!));
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 422) {
        emit(SellerPhotoAndAddressErrorState(
            error.response!.data['message']));
      }else if (error is DioException && error.response?.statusCode == 429) {
        emit(SellerPhotoAndAddressErrorState(
            error.response!.data['message']));
      }
      debugPrint(error.toString());
      emit(SellerCertificatesErrorState(error.toString()));
    });
  }

  File? imagePick;
  void pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    imagePick = File(image!.path);
    emit(SignupPickImageState());
  }

  File? healthCertificate;
  void pickHealthCertificate() async {
    var healthCertificateImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    healthCertificate = File(healthCertificateImage!.path);
    emit(SignupHealthCertificateState());
  }

  File? commercialLicense;
  void pickCommercialLicense() async {
    var commercialLicenseImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    commercialLicense = File(commercialLicenseImage!.path);
    emit(SignupCommercialLicenseState());
  }

  IconData suffixIcon = Icons.visibility;
  bool isObsecure = true;
  void changePasswordVisibility() {
    isObsecure = !isObsecure;
    suffixIcon = isObsecure ? Icons.visibility : Icons.visibility_off;
    emit(SiginupChangePasswordVisibilityState());
  }

  GovernoratesModel? governoratesModel;
  List<SelectedListItem> governoratesList = [];
  void getGovernorates() {
    emit(GetGoverniratesLoadingState());
    DioHelper.getData(
      url: GOVERNORATES,
    ).then((value) {
      governoratesModel = GovernoratesModel.fromJson(value.data);
      if (governoratesModel!.data != null) {
        governoratesModel!.data!.forEach((dataItem) {
          governoratesList.add(SelectedListItem(name: dataItem.name));
          print("ID: ${dataItem.id}, Name: ${dataItem.name}");
        });
      } else {
        print("No data available.");
      }
      emit(GetGoverniratesSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetGoverniratesErrorState(error.toString()));
    });
  }

  List<SelectedListItem> selectedCities = [];
  CityModel? cityModel;
  void getCities(governorateid) {
    emit(GetCitiesLoadingState());
    DioHelper.getData(
      url: CITIES,
      query: {
        'governorate_id': governorateid,
      },
    ).then((value) {
      selectedCities.clear();
      cityModel = CityModel.fromJson(value.data);
      if (cityModel!.data != null) {
        cityModel!.data!.forEach((cityData) {
          selectedCities.add(SelectedListItem(
              name: cityData.name, value: cityData.id.toString()));
          print("City ID: ${cityData.id}, City Name: ${cityData.name}");
        });
      } else {
        print("No cities available for this governorate.");
      }
      emit(GetCitiesSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetCitiesErrorState(error.toString()));
    });
  }
}
