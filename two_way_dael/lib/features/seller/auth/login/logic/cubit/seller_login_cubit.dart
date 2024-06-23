import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/networking/end_points.dart';
import 'package:two_way_dael/features/customer/auth/login/data/models/login_model.dart';

import '../../../../../../core/networking/dio_helper.dart';


part 'seller_login_state.dart';

class SellerLoginCubit extends Cubit<SellerLoginStates> {
  SellerLoginCubit() : super(SellerLoginInitialState());

  static SellerLoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SellerLoginLoadingState());
    DioHelper.postData(
      url: sellerLogin,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      // debugPrint(value.data);
      // print(value.data);
      loginModel = LoginModel.fromJson(value.data);

      emit(SellerLoginSuccessState(loginModel!));
    }).catchError((error) {
      // debugPrint(error.toString());
      if (error is DioException && error.response?.statusCode == 401) {
        print('Unauthorized: ${error.response!.data['message']}');
        emit(SellerLoginUnauthorizedState(error.response!.data['message']));
      } else if (error is DioException && error.response?.statusCode == 429) {
        print('Unauthorized: ${error.response!.data['message']}');
        emit(SellerLoginUnauthorizedState(error.response!.data['message']));
      }
      emit(SellerLoginErrorState(error.toString()));
    });
  }

  final formKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final forgetPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  IconData suffixIcon = Icons.visibility;
  bool isObsecure = true;
  void changePasswordVisibility() {
    isObsecure = !isObsecure;
    suffixIcon = isObsecure ? Icons.visibility : Icons.visibility_off;
    emit(SellerLoginChangePasswordVisibilityState());
  }

  IconData confirmSuffixIcon = Icons.visibility;
  bool confirmIsObsecure = true;
  void changeConfirmPasswordVisibility() {
    confirmIsObsecure = !confirmIsObsecure;
    confirmSuffixIcon =
        confirmIsObsecure ? Icons.visibility : Icons.visibility_off;
    emit(SellerLoginChangePasswordVisibilityState());
  }

  void checkPhoneNumber({
    required String phone,
  }) {
    emit(PhoneForgetPasswordLoadingState());
    DioHelper.postData(
      url: sellerForgetPassword,
      data: {
        'phone': phone,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      debugPrint(loginModel!.data!.token);
      debugPrint(loginModel!.message);
      emit(PhoneForgetPasswordSuccessState(loginModel!));
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 422) {
        emit(PhoneForgetPasswordErrorState(
            error.response!.data['data']['phone'][0]));
      } else if (error is DioException && error.response?.statusCode == 429) {
        emit(PhoneForgetPasswordErrorState(error.response!.data['message']));
      }
      emit(PhoneForgetPasswordErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }
var otpController = TextEditingController();
  ConfirmPhoneModel? confirmPhoneModel;
  void confirmPhoneNumber({
    required String otp,
    required String token,
  }) {
    emit(ConfirmPhoneNumberLoadingState());
    DioHelper.postData(
      token: token,
      url: sellerForgetPasswordOtp,
      data: {
        'otp': otp,
      },
    ).then((value) {
      confirmPhoneModel = ConfirmPhoneModel.fromJson(value.data);
      debugPrint(value.data['message']);
      emit(ConfirmPhoneNumberSuccessState(confirmPhoneModel!));
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 422) {
        emit(ConfirmPhoneNumberErrorState(
            error.response!.data['data']['otp'][0]));
      } else if (error is DioException && error.response?.statusCode == 401) {
        emit(ConfirmPhoneNumberErrorState(error.response!.data['message']));
      } else if (error is DioException && error.response?.statusCode == 429) {
        emit(ConfirmPhoneNumberErrorState(error.response!.data['message']));
      }
      debugPrint(error.toString());
    });
  }

  void changePassword({
    required String password,
    required String passwordConfirmation,
    required String token,
  }) {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(
      token: token,
      url: sellerForgetPasswordChange,
      data: {
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    ).then((value) {
      confirmPhoneModel = ConfirmPhoneModel.fromJson(value.data);
      debugPrint(value.data['message']);
      emit(ChangePasswordSuccessState(confirmPhoneModel!));
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 422) {
        emit(ChangePasswordErrorState(
            error.response!.data['message']));
      } else if (error is DioException && error.response?.statusCode == 429) {
        emit(ChangePasswordErrorState(error.response!.data['message']));
      }
      debugPrint(error.toString());
    });
  }
}

class ConfirmPhoneModel {
  int? status;
  String? message;

  ConfirmPhoneModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
