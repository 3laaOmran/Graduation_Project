part of 'seller_cubit.dart';

@immutable
sealed class SellerStates {}

final class SellerInitial extends SellerStates {}

final class SellerChangeBottomNavState extends SellerStates {}

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
