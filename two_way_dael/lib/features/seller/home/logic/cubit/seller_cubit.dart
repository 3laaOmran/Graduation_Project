import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/networking/end_points.dart';
import 'package:two_way_dael/features/customer/home/data/models/categoties_model.dart';
import 'package:two_way_dael/features/seller/home/data/models/Seller_products_model.dart';
import 'package:two_way_dael/features/seller/home/data/models/seler_product_details.dart';
import 'package:two_way_dael/features/seller/home/data/models/seller_data_model.dart';
import 'package:two_way_dael/features/seller/home/data/models/seller_notifications_model.dart';
import 'package:two_way_dael/features/seller/home/data/models/seller_update_password.dart';
import 'package:two_way_dael/features/seller/home/ui/views/mian_seller_screen.dart';
import 'package:two_way_dael/features/seller/home/ui/views/profile_seller_screen.dart';
import 'package:two_way_dael/features/seller/home/ui/views/seller_notifications_module.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/build_charity_item.dart';

import '../../../../../core/networking/dio_helper.dart';
import '../../ui/views/seller_products_screen.dart';

part 'seller_state.dart';

class SellerCubit extends Cubit<SellerStates> {
  SellerCubit() : super(SellerInitial());

  static SellerCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;

  List<Widget> sellerBottomScreens = const [
    SellerProductsScreen(),
    HomeScreen(),
    ProfileSellerScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(SellerChangeBottomNavState());
  }

  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var joinDateController = TextEditingController();
  var verifiedController = TextEditingController();
  var yourSalesController = TextEditingController();
  final donateFormKey = GlobalKey<FormState>();
  var detailsController = TextEditingController();
  var amountController = TextEditingController();
  //*--------------------------------------------
  final editProductFormKey = GlobalKey<FormState>();
  var productNameController = TextEditingController();
  var discountController = TextEditingController();
  var productDescriptionController = TextEditingController();
  var priceController = TextEditingController();
  var expirydateController = TextEditingController();
  var quantityController = TextEditingController();
  var availableForController = TextEditingController();
  //*-----------------------------
  final addproductFormKey = GlobalKey<FormState>();
  var addproductNameController = TextEditingController();
  var adddiscountController = TextEditingController();
  var addproductDescriptionController = TextEditingController();
  var addpriceController = TextEditingController();
  var addexpirydateController = TextEditingController();
  var addquantityController = TextEditingController();
  var addavailableForController = TextEditingController();

  var newPasswordController = TextEditingController();
  var oldPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final changePasswordFormKey = GlobalKey<FormState>();

  IconData newSuffixIcon = Icons.visibility;
  bool newIsObsecure = true;
  void changeNewPasswordVisibility() {
    newIsObsecure = !newIsObsecure;
    newSuffixIcon = newIsObsecure ? Icons.visibility : Icons.visibility_off;
    emit(ChaneIconVisibilityState());
  }

  IconData oldSuffixIcon = Icons.visibility;
  bool oldIsObsecure = true;
  void changeOldPasswordVisibility() {
    oldIsObsecure = !oldIsObsecure;
    oldSuffixIcon = oldIsObsecure ? Icons.visibility : Icons.visibility_off;
    emit(ChaneIconVisibilityState());
  }

  IconData confirmSuffixIcon = Icons.visibility;
  bool confirmIsObsecure = true;
  void changeConfirmPasswordVisibility() {
    confirmIsObsecure = !confirmIsObsecure;
    confirmSuffixIcon =
        confirmIsObsecure ? Icons.visibility : Icons.visibility_off;
    emit(ChaneIconVisibilityState());
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    productNameController.clear();
    discountController.clear();
    productDescriptionController.clear();
    priceController.clear();
    expirydateController.clear();
    quantityController.clear();
    availableForController.clear();
    addproductNameController.clear();
    adddiscountController.clear();
    addproductDescriptionController.clear();
    addpriceController.clear();
    addexpirydateController.clear();
    addquantityController.clear();
    addavailableForController.clear();
  }

  SellerDataModel? sellerDataModel;
  void getSellerData() {
    emit(GetSellerDataLoadingState());
    DioHelper.getData(
      url: sellerdata,
      token: sellerToken,
    ).then((value) {
      sellerDataModel = SellerDataModel.fromJson(value.data);
      debugPrint('Name Is :${sellerDataModel!.data!.name}');
      emit(GetSellerDataSuccessState(sellerDataModel!));
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 422) {
        String errorMessage = error.response?.data['message'];
        print('Error: $errorMessage');
        emit(GetSellerDataErrorState(errorMessage));
      } else if (error is DioException && error.response?.statusCode == 429) {
        print('Unauthorized: ${error.response!.data['message']}');
        emit(GetSellerDataErrorState(error.response!.data['message']));
      } else {
        debugPrint(error.toString());
        emit(GetSellerDataErrorState(error.toString()));
      }
    });
  }

  SellerUpdatePasswordModel? sellerUpdatePasswordModel;
  void updatePassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) async {
    emit(SellerUpdatePasswordLoadingState());
    DioHelper.postData(
      url: sellerUpdatePasswordPoint,
      token: sellerToken,
      data: {
        'old_password': oldPassword,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    ).then((value) {
      sellerUpdatePasswordModel =
          SellerUpdatePasswordModel.fromJson(value.data);
      emit(SellerUpdatePasswordSuccessState(sellerUpdatePasswordModel!));
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 422) {
        String errorMessage = error.response?.data['message'];
        print('Error: $errorMessage');
        emit(SellerUpdatePasswordErrorState(errorMessage));
      } else if (error is DioException && error.response?.statusCode == 429) {
        print('Unauthorized: ${error.response!.data['message']}');
        emit(SellerUpdatePasswordErrorState(error.response!.data['message']));
      }
    });
  }

  SellerProducts? sellerProducts;
  void getSellerProducts() {
    emit(GetSellerProductsLoadingState());
    DioHelper.getData(
      url: sellerProducsEndPoint,
      token: sellerToken,
    ).then((value) {
      sellerProducts = SellerProducts.fromJson(value.data);
      debugPrint('SellerProducts Is :${sellerProducts!.message!}');

      emit(GetSellerProductsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetSellerProductsErrorState(error.toString()));
    });
  }

  void editSellerProduct({
    required int id,
    required String name,
    required String description,
    required int categoryId,
    required double price,
    required double discount,
    required DateTime expiryDate,
    required DateTime availableFor,
    required double quantity,
    required List<File> images,
  }) {
    final formattedExpiryDate = DateFormat('yyyy-MM-dd').format(expiryDate);
    final formattedAvailableFor = DateFormat('yyyy-MM-dd').format(availableFor);
    emit(EditSellerProductsLoadingState());
    DioHelper.postProduct(
      url: 'seller/product/$id',
      token: sellerToken,
      images: images,
      name: name,
      description: description,
      categoryId: categoryId,
      price: price,
      discount: discount,
      expiryDate: formattedExpiryDate,
      availableFor: formattedAvailableFor,
      quantity: quantity,
    ).then((value) {
      debugPrint('ProductEditedSuccessfully');
      emit(EditSellerProductsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(EditSellerProductsErrorState(error.toString()));
    });
  }

  void deleteSellerProduct({required int id}) {
    emit(DeleteSellerProductsLoadingState());
    DioHelper.postData(
      url: 'seller/product/$id/delete',
      token: sellerToken,
      data: {},
    ).then((value) {
      debugPrint('ProductDeletedSuccessfully');
      emit(DeleteSellerProductsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(DeleteSellerProductsErrorState(error.toString()));
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

  int? selectedCategoryId;

  void selectCategory(int id) {
    selectedCategoryId = id;
    emit(CategorySelectedState(selectedCategoryId!));
  }

  NotificationDetails? notificationDetails;
  Future<void> getNotificationDetails({required String id}) async {
    emit(GetNotificationDetailsLoadingState());
    DioHelper.getData(
      url: 'seller/notification/$id',
      token: sellerToken,
    ).then((value) {
      notificationDetails = NotificationDetails.fromJson(value.data);
      emit(GetNotificationDetailsSuccessState(notificationDetails!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetNotificationDetailsErrorState(error.toString()));
    });
  }

  // void showNotificationDetails(NotificationItem notification, context) {
  //   markNotificationAsRead(sellerNotifications.indexOf(notification));
  //   emit(SellerNotificationsState());
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       backgroundColor: Colors.white,
  //       title: Center(child: Text(notification.title)),
  //       content: Text(notification.message),
  //       actions: [
  //         AppTextButton(
  //           buttonText: 'Close',
  //           textStyle: TextStyles.font12White,
  //           onPressed: () {
  //             context.pop();
  //           },
  //           buttonWidth: 80,
  //           buttonHeight: 15,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  SellerProductDetails? sellerProductDetails;
  Future<void> getSellerProductDetails({required int id}) async {
    emit(GetSellerProductDetailsLoadingState());
    try {
      final response = await Dio().get(
        'http://2waydeal.online/api/seller/product/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $sellerToken',
          },
        ),
      );
      sellerProductDetails = SellerProductDetails.fromJson(response.data);
      emit(GetSellerProductDetailsSuccessState(sellerProductDetails!));
    } catch (error) {
      emit(GetSellerProductDetailsErrorState(error.toString()));
    }
  }

  void addSellerProduct({
    required List<File> images,
    required int categoryId,
    required double price,
    required double discount,
    required String name,
    required String description,
    required DateTime expiryDate,
    required DateTime availableFor,
    required double quantity,
  }) {
    final formattedExpiryDate = DateFormat('yyyy-MM-dd').format(expiryDate);
    final formattedAvailableFor = DateFormat('yyyy-MM-dd').format(availableFor);

    emit(SellerAddProductLoadingState());

    DioHelper.postProduct(
      token: sellerToken,
      url: sellerProducsEndPoint,
      images: images,
      categoryId: categoryId,
      name: name,
      description: description,
      price: price,
      discount: discount,
      expiryDate: formattedExpiryDate,
      availableFor: formattedAvailableFor,
      quantity: quantity,
    ).then((response) {
      debugPrint('Response from Server: ${response.data}');
      emit(SellerAddProductSuccessState());
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 422) {
        emit(SellerAddProductErrorState(error.response!.data['message']));
      } else if (error is DioException && error.response?.statusCode == 401) {
        emit(SellerAddProductErrorState(error.response!.data['message']));
      }
    });
  }

  List<NotificationItem> sellerNotifications = [];
  NotificationsModel? sellerNotificationsModel;
  void getNotifiCations() {
    emit(GetSellerNotificationsLoadingState());
    DioHelper.getData(
      url: sellersNotifications,
      token: sellerToken,
    ).then((value) {
      sellerNotificationsModel = NotificationsModel.fromJson(value.data);
      if (sellerNotificationsModel!.data != null) {
        sellerNotificationsModel!.data!.forEach((dataItem) {
          sellerNotifications.add(NotificationItem(
            title: dataItem.title!,
            message: dataItem.createdAt!,
            image: 'assets/images/two_way_deal_icon.png',
          ));
        });
      } else {
        print("No data available.");
      }
      emit(GetSellerNotificationsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetSellerNotificationsErrorState(error.toString()));
    });
  }

  List<Widget> charities = [
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/MisrElkhair.png',
        name: 'Misr EL-Khair',
        address: 'Cairo, Egypt',
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/FoodBank.png',
        name: 'Egyption Food Bank ',
        address: 'Cairo, Egypt',
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/AhlMasr.png',
        name: 'Ahl Masr Foundation',
        address: 'Cairo, Egypt',
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/Orman.png',
        name: 'Al Orman Association',
        address: 'Cairo, Egypt',
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/57357.png',
        name: '57357',
        address: 'Cairo, Egypt',
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/MisrElkhair.png',
        name: 'Misr EL-Khair',
        address: 'Cairo, Egypt',
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/FoodBank.png',
        name: 'Egyption Food Bank ',
        address: 'Cairo, Egypt',
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/AhlMasr.png',
        name: 'Ahl Masr Foundation',
        address: 'Cairo, Egypt',
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/Orman.png',
        name: 'Al Orman Association',
        address: 'Cairo, Egypt',
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/57357.png',
        name: '57357',
        address: 'Cairo, Egypt',
      ),
    ),
  ];
}
