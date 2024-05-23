import 'dart:io';

import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:two_way_dael/core/networking/dio_helper.dart';
import 'package:two_way_dael/core/networking/end_points.dart';
import 'package:two_way_dael/features/auth/signup/data/models/address_model.dart';
import 'package:two_way_dael/features/auth/signup/data/models/signup_model.dart';

part 'siginup_state.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialState());
  static SignupCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final photoAndAddressFormKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var governorateController = TextEditingController();
  var cityController = TextEditingController();

  SignupModel? signupModel;
  // String? signupToken;
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
      // debugPrint(value.data);
      // print(value.data['token']);
      signupModel = SignupModel.fromJson(value.data);
      // signupToken = value.data['token'];
      emit(SignupSuccessState(signupModel!));
    }).catchError((error) {
      emit(SignupErrorState(error.toString()));
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
      debugPrint(error.toString());
      emit(VerificationErrorState(error.toString()));
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

  List<SelectedListItem> citiesList = [
    SelectedListItem(name: 'Abohomoss'),
    SelectedListItem(name: 'El8Pzor'),
    SelectedListItem(name: 'KafrEldawar'),
    SelectedListItem(name: 'Balakter'),
    SelectedListItem(name: 'Elgenawia'),
    SelectedListItem(name: 'Dsoness'),
  ];

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
          // Create SelectedListItem object and add it to the list
          governoratesList.add(SelectedListItem(name: dataItem.name));
          print("ID: ${dataItem.id}, Name: ${dataItem.name}");
        });
        // Now you have the data stored in the selectedItems list for later use
      } else {
        print("No data available.");
      }
      emit(GetGoverniratesSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetGoverniratesErrorState(error.toString()));
    });
  }
}

//-------------------------

// class GovernoratesModel {
//   int? status;
//   String? message;
//   GoverNorateData? data;

//   GovernoratesModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? GoverNorateData.fromJson(json['data']) : null;
//   }
// }

// class GoverNorateData {
//   int? id;
//   String? name;

//   GoverNorateData.fromJson(List<dynamic> json) {
//     id = json[0]['id'];
//     name = json[0]['name'];
//   }
// }