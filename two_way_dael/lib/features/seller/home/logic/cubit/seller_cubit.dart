import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/networking/end_points.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/seller/home/data/models/Seller_products_model.dart';
import 'package:two_way_dael/features/seller/home/data/models/seler_product_details.dart';
import 'package:two_way_dael/features/seller/home/data/models/seller_data_model.dart';
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
  //*--------------------------------------------
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
      debugPrint('Imge Is :${sellerDataModel!.data!.name}');
      emit(GetSellerDataSuccessState(sellerDataModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetSellerDataErrorState(error.toString()));
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

  void markNotificationAsRead(int index) {
    sellerNotifications[index].isNew = false;
    sortNotifications();
    emit(SellerNotificationsState());
  }

  void deleteNotificatins(index) {
    sellerNotifications.removeAt(index);
    sortNotifications();
    emit(SellerDeleteNotificationsState());
  }

  void sortNotifications() {
    sellerNotifications
        .sort((a, b) => (b.isNew ? 1 : 0).compareTo(a.isNew ? 1 : 0));
  }

  void showNotificationDetails(NotificationItem notification, context) {
    markNotificationAsRead(sellerNotifications.indexOf(notification));
    emit(SellerNotificationsState());
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

  debugPrint('Sending Data to Server:');
  debugPrint('Category ID: $categoryId');
  debugPrint('Price: $price');
  debugPrint('Discount: $discount');
  debugPrint('Name: $name');
  debugPrint('Description: $description');
  debugPrint('Expiry Date: $formattedExpiryDate');
  debugPrint('Available For: $formattedAvailableFor');
  debugPrint('Quantity: $quantity');

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
    if (error is DioException) {
      debugPrint('DioError: ${error.response?.data}');
    } else {
      debugPrint('Unexpected Error: $error');
    }
    emit(SellerAddProductErrorState(error.toString()));
  });
}
  List<NotificationItem> sellerNotifications = [
    NotificationItem(
      title: 'Seller',
      message: 'Seller: Alaa Meawd Omran',
      image: 'assets/images/default_profile.png',
    ),
    NotificationItem(
      title: '3laaOmran',
      message:
          'Alaa Meawd OmranAlaa Meawd OmranAlaa Meawd OmranAlaa Meawd OmranAlaa Meawd Omran',
      image: 'assets/images/default_profile.png',
    ),
    NotificationItem(
      title: 'Two way dael',
      message: 'Alaa Meawd Omran',
      image: 'assets/images/default_profile.png',
    ),
    NotificationItem(
      title: 'Two Way Deal',
      message: 'Alaa Meawd Omran',
      image: 'assets/images/default_profile.png',
    ),
    NotificationItem(
      title: 'Two Way Deal',
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
  List<Widget> charities = [
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/MisrElkhair.png',
        name: 'Misr EL-Khair',
        value: 796,
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/FoodBank.png',
        name: 'Egyption Food Bank ',
        value: 152,
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/AhlMasr.png',
        name: 'Ahl Masr Foundation',
        value: 150,
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/Orman.png',
        name: 'Al Orman Association',
        value: 888,
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/57357.png',
        name: '57357',
        value: 888,
      ),
    ),
    BuildCharityItem(
      charityItemModel: CharityItemModel(
        image: 'assets/images/MisrElkhair.png',
        name: 'Misr EL-Khair',
        value: 796,
      ),
    ),
  ];
}
