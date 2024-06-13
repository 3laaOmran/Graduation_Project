// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/customer/auth/signup/data/models/get_gov_and_city_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/get_profile_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/product_details_model.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/customer_home_screen.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/customer_profile_screen.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/notifications_module.dart';
import '../../../../../core/networking/dio_helper.dart';
import '../../../../../core/networking/end_points.dart';
import '../../data/models/categoties_model.dart';
import '../../data/models/products_model.dart';

class CustomerCubit extends Cubit<CustomerStates> {
  CustomerCubit() : super(CustomerInitialState());

  static CustomerCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const CustomerHomeScreen(),
    const CustomerProfileScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  void toggleCart(Products product) {
    if (cartProducts.contains(product)) {
      cartProducts.remove(product);
      saveCart();
      emit(CustomerRemoveFromCartState());
    } else {
      cartProducts.add(product);
      saveCart();
      emit(CustomerAddToCartState());
    }
  }

  bool isInCart(Products product) {
    return cartProducts.contains(product);
  }

  List<Products> cartProducts = [];
  double totalPrice = 0;

  Future<void> saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartJson =
        cartProducts.map((product) => json.encode(product.toJson())).toList();
    await prefs.setStringList('cartProducts', cartJson);
    await prefs.setDouble('totalPrice', totalPrice);
  }

  Future<void> loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartJson = prefs.getStringList('cartProducts');
    if (cartJson != null) {
      cartProducts =
          cartJson.map((item) => Products.fromJson(json.decode(item))).toList();
    }
    totalPrice = prefs.getDouble('totalPrice') ?? 0;
    emit(CustomerCartLoadedState(cartProducts, totalPrice));
  }

  void minus(Products product) {
    int index = cartProducts.indexOf(product);
    if (index != -1 && cartProducts[index].quantity > 1) {
      cartProducts[index].quantity--;
      updateTotalPrice();
      emit(ItemQuantityMinusState());
      saveCart();
    }
  }

  void plus(Products product) {
    int index = cartProducts.indexOf(product);
    if (index != -1) {
      cartProducts[index].quantity++;
      updateTotalPrice();
      emit(ItemQuantityPlusState());
      saveCart();
    }
  }

  void updateCartItemQuantity(int index, int newQuantity) {
    if (newQuantity > 0) {
      cartProducts[index].quantity = newQuantity;
      updateTotalPrice();
      emit(ItemQuantityUpdatedState(newQuantity));
      saveCart();
    }
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in cartProducts) {
      total += item.price! * item.quantity;
    }
    return total;
  }

  void updateTotalPrice() {
    totalPrice = getTotalPrice();
    emit(CustomerUpdateTotalPriceState(totalPrice));
    saveCart();
  }

  void addToCart(Products product) {
    if (!cartProducts.contains(product)) {
      cartProducts.add(product);
      updateTotalPrice();
      emit(CustomerAddToCartState());
      saveCart();
    }
  }

  void removeFromCart(Products product) {
    if (cartProducts.contains(product)) {
      cartProducts.remove(product);
      updateTotalPrice();
      emit(CustomerRemoveFromCartState());
      saveCart();
    }
  }

  void clearCart() {
    cartProducts.clear();
    updateTotalPrice();
    emit(CustomerClearCartState());
    saveCart();
  }

  ProductsModel? productsModel;
  void getProducts() {
    emit(CustomerGetProductsLoadingState());
    DioHelper.getData(
      url: PRODUCTS,
    ).then((value) {
      productsModel = ProductsModel.fromJson(value.data);
      // print(value.data);
      emit(CustomerGetProductsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
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

  // List<ProductsModel> searchProducts = [];
  ProductsModel? searchModel;
  void getSearchData({
    String? name,
    int? categryId,
    String? minPrice,
    String? maxPrice,
    String? sortBy,
    String? sortWith,
  }) async {
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
      searchModel = ProductsModel.fromJson(value.data);
      emit(GetSearchDataSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetSearchDataErrorState(error.toString()));
    });
  }

  ProductDetails? productDetails;
  void getProductDetails({
    required int id,
  }) async {
    emit(GetProductDetailsLoadingState());
    await DioHelper.getData(
      url: 'product/$id',
    ).then((value) {
      productDetails = ProductDetails.fromJson(value.data);
      emit(GetProductDetailsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetProductDetailsErrorState(error.toString()));
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
  List<DropdownMenuItem<String>>? categoriesList = [];
  CategoriesModel? categoriesModel;
  void getCategories() {
    emit(GetCategoriesLoadingState());
    DioHelper.getData(url: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      if (categoriesModel?.data != null) {
        for (var i = 0; i < categoriesModel!.data!.length; i++) {
          categoriesList!.add(
            DropdownMenuItem(
              value: '${categoriesModel!.data![i].id}',
              child: Text('${categoriesModel!.data![i].name}'),
            ),
          );
        }
      }
      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      emit(GetCategoriesErrorState(error.toString()));
    });
  }
}
