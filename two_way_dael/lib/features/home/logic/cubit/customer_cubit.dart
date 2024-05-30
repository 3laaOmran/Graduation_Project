// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
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
      emit(GetUserDataErrorState(error));
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
