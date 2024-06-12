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
