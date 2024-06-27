// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/features/customer/auth/signup/data/models/get_gov_and_city_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/category_details_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/check_out_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/contact_us_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/deals_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/favorites_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/get_profile_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/notifications_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/order_details_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/orders_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/product_details_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/update_password_model.dart';
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
  bool isAboutSelected = true;
  List<Widget> bottomScreens = [
    const CustomerHomeScreen(),
    const CustomerProfileScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  List<Products> cartProducts = [];
  double totalPrice = 0;

  void toggleCart(Products product) {
    int index = cartProducts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      cartProducts.removeAt(index);
      saveCart();
      emit(CustomerRemoveFromCartState());
    } else {
      cartProducts.add(product);
      saveCart();
      emit(CustomerAddToCartState());
    }
  }

  bool isInCart(Products product) {
    return cartProducts.any((p) => p.id == product.id);
  }

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
    int index = cartProducts.indexWhere((p) => p.id == product.id);
    if (index != -1 && cartProducts[index].quantity > 1) {
      cartProducts[index].quantity--;
      updateTotalPrice();
      emit(ItemQuantityMinusState());
      saveCart();
    }
  }

  void plus(Products product) {
    int index = cartProducts.indexWhere((p) => p.id == product.id);
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
      total += double.parse(item.netPrice!) * item.quantity;
    }
    return total;
  }

  void updateTotalPrice() {
    totalPrice = getTotalPrice();
    emit(CustomerUpdateTotalPriceState(totalPrice));
    saveCart();
  }

  void removeFromCart(Products product) {
    int index = cartProducts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      cartProducts.removeAt(index);
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

  int selectedPageNumber = 1;
  ProductsModel? productsModel;
  void getProducts({int? page}) {
    emit(CustomerGetProductsLoadingState());
    DioHelper.getData(
      url: PRODUCTS,
      query: {'page': page},
    ).then((value) {
      productsModel = ProductsModel.fromJson(value.data);
      // print(value.data);
      emit(CustomerGetProductsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CustomerGetProductsErrorState());
    });
  }

  void sellerProductsPagination({int? page, int? id}) {
    emit(CustomerGetSellerProductsPaginationLoadingState());
    DioHelper.getData(
      url: 'products/seller/$id',
      query: {'page': page},
    ).then((value) {
      productsModel2 = ProductsModel.fromJson(value.data);
      // print(value.data);
      emit(CustomerGetSellerProductsPaginationSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CustomerDecreaseCartItemQuantityErrorState());
    });
  }

  ProductsModel? productsModel2;
  void getSellerProducts({int? id}) {
    emit(CustomerGetSellerProductsLoadingState());
    DioHelper.getData(
      url: 'products/seller/$id',
    ).then((value) {
      productsModel2 = ProductsModel.fromJson(value.data);
      // print(value.data);
      emit(CustomerGetSellerProductsSuccessState(productsModel2!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CustomerGetSellerProductsErrorState());
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

  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required int governorate,
    required int city,
  }) {
    emit(CustomerUpdateProfileLoadingState());

    try {
      DioHelper.postData(
        url: UPDATEPROFILE,
        token: token,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'governorate_id': governorate,
          'city_id': city,
        },
      ).then((value) {
        userDataModel = UserDataModel.fromJson(value.data);
        emit(CustomerUpdateProfileSuccessState(userDataModel));
      }).catchError((error) {
        if (error is DioException && error.response != null) {
          final errorMessage =
              'Error ${error.response?.statusCode}: ${error.response?.data['message']}';
          emit(CustomerUpdateProfileErrorState(errorMessage));
        } else {
          emit(CustomerUpdateProfileErrorState(
              'An unexpected error occurred: $error'));
        }
      });
    } catch (error) {
      emit(CustomerUpdateProfileErrorState(
          'An unexpected error occurred: $error'));
    }
  }

  void updateProfileImage({
    required File image,
  }) async {
    emit(CustomerUpdateImageLoadingState());

    Map<String, dynamic> data = {
      'image': await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    };

    DioHelper.postData(
      url: UPDATEIMAGEPROFILE,
      token: token,
      data: data,
    ).then((value) {
      userDataModel = UserDataModel.fromJson(value.data);
      emit(CustomerUpdateImageSuccessState(userDataModel));
    }).catchError((error) {
      if (error is DioException && error.response != null) {
        if (error.response?.statusCode == 422) {
          final errorMessage =
              'Error ${error.response?.statusCode}: The image must be in a valid format.';
          emit(CustomerUpdateImageErrorState(errorMessage));
        } else {
          final errorMessage =
              'Error ${error.response?.statusCode}: ${error.response?.data['message']}';
          emit(CustomerUpdateImageErrorState(errorMessage));
        }
      } else {
        emit(CustomerUpdateImageErrorState(
            'An unexpected error occurred: $error'));
      }
    });
  }

  UpdatePasswordModel? updatePasswordModel;
  void updatePassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) async {
    emit(CustomerUpdatePasswordLoadingState());
    DioHelper.postData(
      url: UPDATEPASSWORD,
      token: token,
      data: {
        'old_password': oldPassword,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    ).then((value) {
      updatePasswordModel = UpdatePasswordModel.fromJson(value.data);
      emit(CustomerUpdatePasswordSuccessState(updatePasswordModel));
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 422) {
        String errorMessage = error.response?.data['message'];
        print('Error: $errorMessage');
        emit(CustomerUpdatePasswordErrorState(errorMessage));
      } else if (error is DioException && error.response?.statusCode == 429) {
        print('Unauthorized: ${error.response!.data['message']}');
        emit(CustomerUpdatePasswordErrorState(error.response!.data['message']));
      }
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
      token: token,
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

  CategoryDetails? categoryDetails;
  void getCategoryDetails({
    required int? id,
  }) async {
    emit(GetCategoryDetailsLoadingState());
    await DioHelper.getData(
      url: 'category/$id',
    ).then((value) {
      categoryDetails = CategoryDetails.fromJson(value.data);
      emit(GetCategoryDetailsSuccessState(categoryDetails));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetCategoryDetailsErrorState(error.toString()));
    });
  }

  void addToFavorites({required int id}) {
    emit(AddToFavoritesLoadingState());
    DioHelper.postData(
      url: 'me/favourites',
      data: {
        'seller_id': id,
      },
      token: token,
    ).then((value) {
      emit(AddToFavoritesSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(AddToFavoritesErrorState(error.toString()));
    });
  }

  void removeFromFavorites({required int id}) {
    emit(RemoveFromFavoritesLoadingState());
    DioHelper.postData(
      url: 'me/favourites/$id',
      data: {},
      token: token,
    ).then((value) {
      emit(RemoveFromFavoritesSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(RemoveFromFavoritesErrorState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoriteSellers() {
    emit(GetFavoriteSellersLoadingState());
    DioHelper.getData(
      url: 'me/favourites',
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(GetFavoriteSellersSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetFavoriteSellersErrorState(error.toString()));
    });
  }

  void rateSeller({
    required int id,
    required int rate,
  }) {
    emit(CustomerRateSellersLoadingState());
    DioHelper.postData(
      url: 'me/rate-seller/$id',
      data: {
        'value': rate,
        'store_id': id,
      },
      token: token,
    ).then((value) {
      emit(CustomerRateSellersSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CustomerRateSellersErrorState(error.toString()));
    });
  }

  AboutAppModel? aboutAppModel;
  void getAboutApp() async {
    emit(AboutAppLoadingState());
    await DioHelper.getData(
      url: ABOUTAPP,
    ).then((value) {
      aboutAppModel = AboutAppModel.fromJson(value.data);
      emit(AboutAppSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(AboutAppErrorState(error.toString()));
    });
  }

  final titleController = TextEditingController();
  final messageController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();

  ContactUsModel? contactUsModel;
  void contactUs({
    required String subject,
    required String message,
  }) {
    emit(ContactUsLoadingState());
    try {
      DioHelper.postData(
        url: CONTACTUS,
        token: token ?? sellerToken,
        data: {
          'subject': subject,
          'message': message,
        },
      ).then((value) {
        contactUsModel = ContactUsModel.fromJson(value.data);
        emit(ContactUsSuccessState(contactUsModel!));
      }).catchError((error) {
        if (error is DioException && error.response != null) {
          final errorMessage =
              'Error ${error.response?.statusCode}: ${error.response?.data['message']}';
          emit(ContactUsErrorState(errorMessage));
        } else {
          emit(ContactUsErrorState('An unexpected error occurred: $error'));
        }
      });
    } catch (error) {
      emit(ContactUsErrorState('An unexpected error occurred: $error'));
    }
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

  CustomerOrdersModel? customerOrders;
  void getCustomerOrders() {
    emit(GetCustomerOrdersLoadingState());

    DioHelper.getData(
      url: customerOrdersUrl,
      token: token,
    ).then((value) {
      customerOrders = CustomerOrdersModel.fromJson(value.data);
      debugPrint(customerOrders!.message);
      emit(GetCustomerOrdersSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetCustomerOrdersErrorState(error.toString()));
    });
  }

  OrderDetailsModel? orderDetails;
  void getCustomerOrderDetails({required int? id}) {
    emit(GetCustomerOrderDetailsLoadingState());

    DioHelper.getData(
      url: 'me/order/$id',
      token: token,
    ).then((value) {
      orderDetails = OrderDetailsModel.fromJson(value.data);
      debugPrint(orderDetails!.message);
      emit(GetCustomerOrderDetailsSuccessState(orderDetails!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetCustomerOrderDetailsErrorState(error.toString()));
    });
  }

  List<NotificationItem> notifications = [];
  NotificationsModel? notificationsModel;
  void getNotifiCations() {
    emit(GetNotificationsLoadingState());
    DioHelper.getData(
      url: 'me/notifications',
      token: token,
    ).then((value) {
      notificationsModel = NotificationsModel.fromJson(value.data);
      if (notificationsModel!.data != null) {
        notificationsModel!.data!.forEach((dataItem) {
          notifications.add(NotificationItem(
            title: dataItem.title!,
            message: dataItem.createdAt!,
            image: 'assets/images/two_way_deal_icon.png',
          ));
        });
      } else {
        print("No data available.");
      }
      emit(GetNotificationsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetNotificationsErrorState(error.toString()));
    });
  }

  NotifiDetails? notifiDetails;
  Future<void> getNotificationDetails({required String id}) async {
    emit(GetNotificationDetailsLoadingState());
    DioHelper.getData(
      url: 'me/notification/$id',
      token: token,
    ).then((value) {
      notifiDetails = NotifiDetails.fromJson(value.data);
      emit(GetNotificationDetailsSuccessState(notifiDetails!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetNotificationDetailsErrorState(error.toString()));
    });
  }

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

  Deals? deals;
  void getHotDealsAndOffers() {
    emit(GetHotDealsAndOffersLoadingState());
    DioHelper.getData(
      url: 'deals',
    ).then((value) {
      deals = Deals.fromJson(value.data);
      emit(GetHotDealsAndOffersSuccessState());
    }).catchError((error) {
      emit(GetHotDealsAndOffersErrorState(error.toString()));
    });
  }

  BestsaleModel? bestsaleModel;
  void getBestSale({required int id}) {
    emit(GetBestSalesLoadingState());
    DioHelper.getData(
      url: 'deals/$id',
    ).then((value) {
      bestsaleModel = BestsaleModel.fromJson(value.data);
      emit(GetBestSalesSuccessState(bestsaleModel!));
    }).catchError((error) {
      emit(GetBestSalesErrorState(error.toString()));
    });
  }

  BestsaleModel? bestsaleModel2;
  void getTopDeals({required int id}) {
    emit(GetTopDealsLoadingState());
    DioHelper.getData(
      url: 'deals/$id',
    ).then((value) {
      bestsaleModel2 = BestsaleModel.fromJson(value.data);
      emit(GetTopDealsSuccessState(bestsaleModel2!));
    }).catchError((error) {
      emit(GetTopDealsErrorState(error.toString()));
    });
  }
CheckoutModel? checkoutModel;
  void checkout({
    required String address,
    required double totalPrice,
    required Map products,
    required bool shipping,
  }) {
    emit(CheckoutLoadingState());
    DioHelper.postData(
      url: 'me/checkout',
      data: {
        "shipping": shipping,
        "address": address,
        "total_price": totalPrice,
        "products": products
      },
      token: token,
    ).then((value) {
      checkoutModel = CheckoutModel.fromJson(value.data);
      emit(CheckoutSuccessState(checkoutModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CheckoutErrorState(error.toString()));
    });
  }
  void payment({
    required String expiry,
    required int cardNumber,
    required  String cvv,
    required int invoiceId,
    required int orderId,
  }) {
    emit(PaymentLoadingState());
    DioHelper.postData(
      url: 'me/pay',
      data: {
        "order_id": 23,
        "invoice_id": 1,
        "card_number": 4111111111211111,
        "card_expiry" : "04/22",
        "card_cvv" : "123"
      },
      token: token,
    ).then((value) {
      emit(PaymentSuccessState());
    }).catchError((error) {
      emit(PaymentErrorState(error.toString()));
    });
  }
}
