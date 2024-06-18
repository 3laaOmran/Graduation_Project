part of 'seller_cubit.dart';

@immutable
sealed class SellerStates {}

final class SellerInitial extends SellerStates {}

final class SellerChangeBottomNavState extends SellerStates {}

class GetNotificationDetailsLoadingState extends SellerStates {}

class GetNotificationDetailsSuccessState extends SellerStates {
  final NotificationDetails notificationDetails;

  GetNotificationDetailsSuccessState(this.notificationDetails);
}

class GetNotificationDetailsErrorState extends SellerStates {
  final String error;

  GetNotificationDetailsErrorState(this.error);
}

class GetCategoriesLoadingState extends SellerStates {}

class GetCategoriesSuccessState extends SellerStates {}

class GetCategoriesErrorState extends SellerStates {
  final String error; 

  GetCategoriesErrorState(this.error);
}

class CategorySelectedState extends SellerStates {
  final int selectedCategoryId;
  CategorySelectedState(this.selectedCategoryId);
}

class SellerNotificationsState extends SellerStates {}

class SellerDeleteNotificationsState extends SellerStates {}

class GetSellerDataLoadingState extends SellerStates {}

class GetSellerDataSuccessState extends SellerStates {
  final SellerDataModel sellerDataModel;

  GetSellerDataSuccessState(this.sellerDataModel);
}

class GetSellerDataErrorState extends SellerStates {
  final String error;

  GetSellerDataErrorState(this.error);
}

class SellerUpdatePasswordLoadingState extends SellerStates {}

class ChaneIconVisibilityState extends SellerStates {}

class SellerUpdatePasswordSuccessState extends SellerStates {
  final SellerUpdatePasswordModel sellerUpdatePasswordModel;

  SellerUpdatePasswordSuccessState(this.sellerUpdatePasswordModel);
}

class SellerUpdatePasswordErrorState extends SellerStates {
  final String error;

  SellerUpdatePasswordErrorState(this.error);
}

class GetSellerProductsLoadingState extends SellerStates {}

class GetSellerProductsSuccessState extends SellerStates {}

class GetSellerProductsErrorState extends SellerStates {
  final String error;

  GetSellerProductsErrorState(this.error);
}

class EditSellerProductsLoadingState extends SellerStates {}

class EditSellerProductsSuccessState extends SellerStates {}

class EditSellerProductsErrorState extends SellerStates {
  final String error;

  EditSellerProductsErrorState(this.error);
}

class GetSellerNotificationsLoadingState extends SellerStates {}

class GetSellerNotificationsSuccessState extends SellerStates {}

class GetSellerNotificationsErrorState extends SellerStates {
  final String error;

  GetSellerNotificationsErrorState(this.error);
}

class DeleteSellerProductsLoadingState extends SellerStates {}

class DeleteSellerProductsSuccessState extends SellerStates {}

class DeleteSellerProductsErrorState extends SellerStates {
  final String error;

  DeleteSellerProductsErrorState(this.error);
}

class GetSellerProductDetailsLoadingState extends SellerStates {}

class GetSellerProductDetailsSuccessState extends SellerStates {
  final SellerProductDetails sellerProductDetails;

  GetSellerProductDetailsSuccessState(this.sellerProductDetails);
}

class GetSellerProductDetailsErrorState extends SellerStates {
  final String error;

  GetSellerProductDetailsErrorState(this.error);
}

class SellerAddProductLoadingState extends SellerStates {}

class SellerAddProductSuccessState extends SellerStates {
  // final SellerProductDetails sellerProductDetails;

  // GetSellerProductDetailsSuccessState(this.sellerProductDetails);
}

class SellerAddProductErrorState extends SellerStates {
  final String error;

  SellerAddProductErrorState(this.error);
}
