import 'package:two_way_dael/features/customer/auth/login/data/models/login_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/get_profile_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/products_model.dart';

abstract class CustomerStates {}

class CustomerInitialState extends CustomerStates {}

class ChangeBottomNavState extends CustomerStates {}

// class ItemQuantityMinusState extends CustomerStates {
  // int itemQuantity;
  // double itemPrice;
  // double totalPrice;

  // ItemQuantityMinusState(this.itemQuantity, this.itemPrice, this.totalPrice);
// }

// class ItemQuantityPlusState extends CustomerStates {
  // int itemQuantity;
  // double itemPrice;
  // double totalPrice;

  // ItemQuantityPlusState(this.itemQuantity, this.itemPrice, this.totalPrice);
// }

// class CustomerRemoveFromCartState extends CustomerStates {}
// class CustomerClearCartState extends CustomerStates {}
// class CustomerAddToCartState extends CustomerStates {}
// class CustomerCartUpdated extends CustomerStates {}

class CustomerGetProductsLoadingState extends CustomerStates {}

class CustomerGetProductsSuccessState extends CustomerStates {}

class CustomerGetProductsErrorState extends CustomerStates {}

final class GetUserDataLoadingState extends CustomerStates {}

final class GetUserDataSuccessState extends CustomerStates {
  final UserDataModel userDataModel;

  GetUserDataSuccessState(this.userDataModel);
}

final class GetUserDataErrorState extends CustomerStates {
  final String error;

  GetUserDataErrorState(this.error);
}

final class GetSearchDataLoadingState extends CustomerStates {}

final class GetSearchDataSuccessState extends CustomerStates {}

final class GetSearchDataErrorState extends CustomerStates {
  final String error;

  GetSearchDataErrorState(this.error);
}

final class GetProductDetailsLoadingState extends CustomerStates {}

final class GetProductDetailsSuccessState extends CustomerStates {}

final class GetProductDetailsErrorState extends CustomerStates {
  final String error;

  GetProductDetailsErrorState(this.error);
}

final class GetGoverniratesLoadingState extends CustomerStates {}

final class GetGoverniratesSuccessState extends CustomerStates {}

final class GetGoverniratesErrorState extends CustomerStates {
  final String error;

  GetGoverniratesErrorState(this.error);
}

final class GetCitiesLoadingState extends CustomerStates {}

final class GetCitiesSuccessState extends CustomerStates {}

final class GetCitiesErrorState extends CustomerStates {
  final String error;

  GetCitiesErrorState(this.error);
}

final class GetCategoriesLoadingState extends CustomerStates {}

final class GetCategoriesSuccessState extends CustomerStates {}

final class GetCategoriesErrorState extends CustomerStates {
  final String error;

  GetCategoriesErrorState(this.error);
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
class CustomerCartLoadedState extends CustomerStates {
  final List<Products> cartProducts;
  final double totalPrice;

  CustomerCartLoadedState(this.cartProducts, this.totalPrice);
}

class ItemQuantityMinusState extends CustomerStates {
  // int itemQuantity;
  // double itemPrice;
  // double totalPrice;

  // ItemQuantityMinusState(this.itemQuantity, this.itemPrice, this.totalPrice);
}

class ItemQuantityUpdatedState extends CustomerStates {
  int newItemPrice;
  // double totalPrice;
  ItemQuantityUpdatedState(this.newItemPrice);
}

class ItemQuantityPlusState extends CustomerStates {
  // double newItemPrice;
  // double totalPrice;
  // ItemQuantityPlusState(this.newItemPrice, this.totalPrice);
}

class CustomerCartInitializedState extends CustomerStates {}
class CustomerRemoveFromCartState extends CustomerStates {}

class CustomerClearCartState extends CustomerStates {}

class CustomerAddToCartState extends CustomerStates {}

class CustomerCartUpdated extends CustomerStates {}

class CustomerAddTotalPriceState extends CustomerStates {
  double totalPrice;
  CustomerAddTotalPriceState(
    this.totalPrice,
  );
}

class CustomerRemoveTotalPriceState extends CustomerStates {
  double totalPrice;
  CustomerRemoveTotalPriceState(this.totalPrice);
}

class CustomerUpdateTotalPriceState extends CustomerStates {
  double totalPrice;
  CustomerUpdateTotalPriceState(this.totalPrice);
}
class CustomerUpdateCartItemQuantityState extends CustomerStates {}

class CustomerIncreaseCartItemQuantityState extends CustomerStates {}

class CustomerDecreaseCartItemQuantitySuccessState extends CustomerStates {}

class CustomerDecreaseCartItemQuantityErrorState extends CustomerStates {}