import 'package:two_way_dael/features/auth/login/data/models/login_model.dart';

abstract class CustomerStates {}

class CustomerInitialState extends CustomerStates {}

class ChangeBottomNavState extends CustomerStates {}

class ItemQuantityMinusState extends CustomerStates {
  int itemQuantity;
  double itemPrice;
  double totalPrice;

  ItemQuantityMinusState(this.itemQuantity, this.itemPrice, this.totalPrice);
}

class ItemQuantityPlusState extends CustomerStates {
  int itemQuantity;
  double itemPrice;
  double totalPrice;

  ItemQuantityPlusState(this.itemQuantity, this.itemPrice, this.totalPrice);
}

class CustomerGetProductsLoadingState extends CustomerStates {}

class CustomerGetProductsSuccessState extends CustomerStates {}

class CustomerGetProductsErrorState extends CustomerStates {}

final class GetUserDataLoadingState extends CustomerStates {}

final class GetUserDataSuccessState extends CustomerStates {
  final LoginModel loginModel;

  GetUserDataSuccessState(this.loginModel);
}

final class GetUserDataErrorState extends CustomerStates {
  final String error;

  GetUserDataErrorState(this.error);
}

final class GetUserDataChaneIconVisibilityState extends CustomerStates {}

class CustomerUpdateProfileLoadingState extends CustomerStates {}

class CustomerUpdateProfileSuccessState extends CustomerStates {
  final LoginModel loginModel;

  CustomerUpdateProfileSuccessState(this.loginModel);
}

class CustomerUpdateProfileErrorState extends CustomerStates {}

class NotificationsState extends CustomerStates {}
class DeleteNotificationsState extends CustomerStates {}
