import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:two_way_dael/core/networking/dio_helper.dart';
import 'package:two_way_dael/core/networking/end_points.dart';
import 'package:two_way_dael/features/customer/auth/signup/data/models/get_gov_and_city_model.dart';
import 'package:two_way_dael/features/customer/auth/signup/data/models/signup_model.dart';

part 'siginup_state.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialState());
  static SignupCubit get(context) => BlocProvider.of(context);

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

  SignupModel? signupModel;
  void userSignup({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(SignupLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      signupModel = SignupModel.fromJson(value.data);
      emit(SignupSuccessState(signupModel!));
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
        emit(SignupUsedEmailOrPhoneErrorState(errorMessage));
      } else if (error is DioException && error.response?.statusCode == 429) {
        print('Unauthorized: ${error.response!.data['message']}');
        emit(SignupUsedEmailOrPhoneErrorState(error.response!.data['message']));
      }
      emit(SignupErrorState(error.toString()));
      debugPrint('errorState: ${error.toString()}');
    });
  }

  VerificationModel? verificationModel;
  void otpVerification({
    required String otp,
    required String token,
  }) {
    emit(VerificationLoadingState());
    DioHelper.postData(
      token: token,
      url: VERIFICATION,
      data: {
        'otp': otp,
      },
    ).then((value) {
      verificationModel = VerificationModel.fromJson(value.data);
      debugPrint(value.data['message']);
      emit(VerificationSuccessState(verificationModel!));
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 422) {
        emit(VerificationOtpErrorState(error.response!.data['data']['otp'][0]));
      } else if (error is DioException && error.response?.statusCode == 401) {
        emit(VerificationOtpErrorState(error.response!.data['message']));
      } else if (error is DioException && error.response?.statusCode == 401) {
        emit(VerificationOtpErrorState(error.response!.data['message']));
      }
      debugPrint(error.toString());
      emit(VerificationErrorState(error.toString()));
    });
  }

  int? selectedGovernorateId;
  int? selectedCityId;
  PhotoAndAddressModel? photoAndAddressModel;
  void photoAndAddress({
    required int cityId,
    required int governorateId,
    required String token,
    File? image,
  }) {
    emit(PhotoAndAddressLoadingState());

    Map<String, dynamic> data = {
      'city_id': cityId,
      'governorate_id': governorateId,
    };

    DioHelper.postData(
      token: token,
      url: PHOTOANDADDRESS,
      data: data,
      image: image,
    ).then((value) {
      photoAndAddressModel = PhotoAndAddressModel.fromJson(value.data);
      debugPrint(value.data['message']);
      emit(PhotoAndAddressSuccessState(photoAndAddressModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(PhotoAndAddressErrorState(error.toString()));
    });
  }

  File? imagePick;
  void pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    imagePick = File(image!.path);
    emit(SignupPickImageState());
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
