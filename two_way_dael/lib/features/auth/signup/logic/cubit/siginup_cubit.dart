import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:two_way_dael/core/networking/dio_helper.dart';
import 'package:two_way_dael/core/networking/end_points.dart';
import 'package:two_way_dael/features/auth/login/data/models/login_model.dart';

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

  var addressController = TextEditingController();
  var streetController = TextEditingController();
  var zipCodeController = TextEditingController();
  var cityController = TextEditingController();

  LoginModel? loginModel;
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
      loginModel = LoginModel.fromJson(value.data);

      emit(SignupSuccessState(loginModel!));
    }).catchError((error) {
      emit(SignupErrorState(error.toString()));
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
}
