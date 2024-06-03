// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/auth/signup/data/models/get_gov_and_city_model.dart';
import 'package:two_way_dael/features/home/data/models/get_profile_model.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/home/ui/Modules/customer_home_screen.dart';
import 'package:two_way_dael/features/home/ui/Modules/customer_profile_screen.dart';
import 'package:two_way_dael/features/home/ui/Modules/notifications_module.dart';

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

  UserDataModel? userDataModel;
  void getUserData() {
    emit(GetUserDataLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userDataModel = UserDataModel.fromJson(value.data);
      debugPrint('Imge Is :${userDataModel!.data!.profilePicture}');
      emit(GetUserDataSuccessState(userDataModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  List<ProductsModel> searchProducts = [];
  SearchModel? searchModel;
  void getSearchData({
    String? name,
    int? categryId,
    int? minPrice,
    int? maxPrice,
    String? sortBy,
    String? sortWith,
  })async {
    emit(GetSearchDataLoadingState());
    await DioHelper.getData(
      url: SEARCH,
      query: {
        'name': name,
        'category_id': categryId,
        'min_price': minPrice,
        'max_price': maxPrice,
        'sort_by': sortBy,
        'sort_order': sortWith,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(GetSearchDataSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetSearchDataErrorState(error.toString()));
    });
  }

  var governorateController = TextEditingController();
  var cityController = TextEditingController();
  int? selectedGovernorateId;
  int? selectedCityId;
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

  // void updateUserData({
  //   required String name,
  //   required String email,
  //   String? phone,
  // }) {
  //   emit(CustomerUpdateProfileLoadingState());
  //   DioHelper.updateData(
  //     url: UPDATE,
  //     token: token,
  //     data: {
  //       'name': name,
  //       'email': email,
  //       'phone': phone,
  //     },
  //   ).then((value) {
  //     userModel = LoginModel.fromJson(value.data);
  //     // debugPrint(userModel!.data!.email);
  //     emit(CustomerUpdateProfileSuccessState(userModel!));
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //     emit(CustomerUpdateProfileErrorState());
  //   });
  // }

  final formKey = GlobalKey<FormState>();
  final changePasswordFormKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var newPasswordController = TextEditingController();
  var oldPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  IconData newSuffixIcon = Icons.visibility;
  bool newIsObsecure = true;
  void changeNewPasswordVisibility() {
    newIsObsecure = !newIsObsecure;
    newSuffixIcon = newIsObsecure ? Icons.visibility : Icons.visibility_off;
    emit(GetUserDataChaneIconVisibilityState());
  }

  IconData oldSuffixIcon = Icons.visibility;
  bool oldIsObsecure = true;
  void changeOldPasswordVisibility() {
    oldIsObsecure = !oldIsObsecure;
    oldSuffixIcon = oldIsObsecure ? Icons.visibility : Icons.visibility_off;
    emit(GetUserDataChaneIconVisibilityState());
  }

  IconData confirmSuffixIcon = Icons.visibility;
  bool confirmIsObsecure = true;
  void changeConfirmPasswordVisibility() {
    confirmIsObsecure = !confirmIsObsecure;
    confirmSuffixIcon =
        confirmIsObsecure ? Icons.visibility : Icons.visibility_off;
    emit(GetUserDataChaneIconVisibilityState());
  }

  void markNotificationAsRead(int index) {
    notifications[index].isNew = false;
    sortNotifications();
    emit(NotificationsState());
  }

  void deleteNotificatins(index) {
    notifications.removeAt(index);
    sortNotifications();
    emit(DeleteNotificationsState());
  }

  void sortNotifications() {
    notifications.sort((a, b) => (b.isNew ? 1 : 0).compareTo(a.isNew ? 1 : 0));
  }

  void showNotificationDetails(NotificationItem notification, context) {
    markNotificationAsRead(notifications.indexOf(notification));
    emit(NotificationsState());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Center(child: Text(notification.title)),
        content: Text(notification.message),
        actions: [
          AppTextButton(
            buttonText: 'Close',
            textStyle: TextStyles.font12White,
            onPressed: () {
              context.pop();
            },
            buttonWidth: 80,
            buttonHeight: 15,
          ),
        ],
      ),
    );
  }

  List<NotificationItem> notifications = [
    NotificationItem(
      title: '3laa',
      message: 'Alaa Meawd Omran',
      image: 'assets/images/default_profile.png',
    ),
    NotificationItem(
      title: '3laaOmran',
      message:
          'Alaa Meawd OmranAlaa Meawd OmranAlaa Meawd OmranAlaa Meawd OmranAlaa Meawd Omran',
      image: 'assets/images/default_profile.png',
    ),
    NotificationItem(
      title: 'Two',
      message: 'Alaa Meawd Omran',
      image: 'assets/images/default_profile.png',
    ),
    NotificationItem(
      title: 'Way',
      message: 'Alaa Meawd Omran',
      image: 'assets/images/default_profile.png',
    ),
    NotificationItem(
      title: 'Deal',
      message: 'Alaa Meawd Omran',
      image: 'assets/images/default_profile.png',
    ),
    NotificationItem(
      title: 'twoWayDeal',
      message:
          ' Alaa Meawd OmranAlaa Meawd OmranAlaa Meawd OmranAlaa Meawd OmranAlaa Meawd Omran',
      image: 'assets/images/default_profile.png',
    ),
  ];
}

class SearchModel {
  int? status;
  String? message;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? productsCount;
  List<Products>? products;

  Data.fromJson(Map<String, dynamic> json) {
    productsCount = json['products_count'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['products_count'] = productsCount;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  double? price;
  String? discount;
  String? netPrice;
  List<String>? images;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    netPrice = json['net_price'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['discount'] = discount;
    data['net_price'] = netPrice;
    data['images'] = images;
    return data;
  }
}
