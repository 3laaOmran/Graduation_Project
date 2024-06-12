import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/networking/end_points.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/seller/home/data/models/seller_data_model.dart';
import 'package:two_way_dael/features/seller/home/ui/views/mian_seller_screen.dart';
import 'package:two_way_dael/features/seller/home/ui/views/profile_seller_screen.dart';
import 'package:two_way_dael/features/seller/home/ui/views/seller_notifications_module.dart';

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
}
