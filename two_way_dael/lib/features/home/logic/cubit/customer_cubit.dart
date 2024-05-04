import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/features/auth/login/data/models/login_model.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/home/ui/Modules/customer_home_screen.dart';
import 'package:two_way_dael/features/home/ui/Modules/customer_profile_screen.dart';

import '../../../../core/networking/dio_helper.dart';
import '../../../../core/networking/end_points.dart';
import '../../data/models/products_model.dart';

class CustomerCubit extends Cubit<CustomerStates> {
  CustomerCubit() : super(CustomerInitialState());

  static CustomerCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    CustomerHomeScreen(),
    const CustomerProfileScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  int itemQuantity = 1;
  double itemPrice = 75;
  double totalPrice = 75;

  void minus() {
    if (itemQuantity > 1) {
      itemQuantity--;
      totalPrice -= itemPrice;
      emit(ItemQuantityMinusState(itemQuantity, totalPrice, itemPrice));
    }
  }

  void plus() {
    itemQuantity++;
    totalPrice += itemPrice;
    emit(ItemQuantityPlusState(itemQuantity, totalPrice, itemPrice));
  }

  ProductsModel? productsModel;

  void getProducts() {
    emit(CustomerGetProductsLoadingState());
    DioHelper.getData(
      url: GET_PRODUCTS,
    ).then((value) {
      productsModel = ProductsModel.fromJson(value.data);
      print(value.data);
      emit(CustomerGetProductsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CustomerGetProductsErrorState());
    });
  }

  LoginModel? userModel;
  void getUserData() {
    emit(GetUserDataLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      debugPrint(userModel!.data!.email);
      emit(GetUserDataSuccessState(userModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetUserDataErrorState(error));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    String? phone,
  }) {
    emit(CustomerUpdateProfileLoadingState());
    DioHelper.updateData(
      url: UPDATE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      debugPrint(userModel!.data!.email);
      emit(CustomerUpdateProfileSuccessState(userModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CustomerUpdateProfileErrorState());
    });
  }

  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var addressController = TextEditingController();

  IconData suffixIcon = Icons.visibility;
  bool isObsecure = true;
  void changePasswordVisibility() {
    isObsecure = !isObsecure;
    suffixIcon = isObsecure ? Icons.visibility : Icons.visibility_off;
    emit(GetUserDataChaneIconVisibilityState());
  }
}
