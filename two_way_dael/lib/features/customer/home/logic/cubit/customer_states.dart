import 'package:two_way_dael/features/customer/home/data/models/category_details_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/check_out_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/contact_us_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/deals_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/get_profile_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/notifications_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/order_details_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/products_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/update_password_model.dart';

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

class CustomerGetSellerProductsPaginationLoadingState extends CustomerStates {}

class CustomerGetSellerProductsPaginationSuccessState extends CustomerStates {}

class CustomerGetSellerProductsPaginationErrorState extends CustomerStates {}

class CustomerGetSellerProductsLoadingState extends CustomerStates {}

class CustomerGetSellerProductsSuccessState extends CustomerStates {
  final ProductsModel productsModel2;

  CustomerGetSellerProductsSuccessState(this.productsModel2);
}

class CustomerGetSellerProductsErrorState extends CustomerStates {}

final class GetUserDataLoadingState extends CustomerStates {}


final class GetUserDataSuccessState extends CustomerStates {
  final UserDataModel userDataModel;

  GetUserDataSuccessState(this.userDataModel);
}

final class GetUserDataErrorState extends CustomerStates {
  final String error;

  GetUserDataErrorState(this.error);
}

class CustomerUpdateProfileLoadingState extends CustomerStates {}

class CustomerUpdateProfileSuccessState extends CustomerStates {
  final UserDataModel? userDataModel;

  CustomerUpdateProfileSuccessState(this.userDataModel);
}

class CustomerUpdateProfileErrorState extends CustomerStates {
  final String error;
  CustomerUpdateProfileErrorState(this.error);
}

class CustomerUpdateImageLoadingState extends CustomerStates {}

class CustomerUpdateImageSuccessState extends CustomerStates {
  final UserDataModel? userDataModel;

  CustomerUpdateImageSuccessState(this.userDataModel);
}

class CustomerUpdateImageErrorState extends CustomerStates {
  final String error;
  CustomerUpdateImageErrorState(this.error);
}

class CustomerUpdatePasswordLoadingState extends CustomerStates {}

class CustomerUpdatePasswordSuccessState extends CustomerStates {
  final UpdatePasswordModel? updatePasswordModel;

  CustomerUpdatePasswordSuccessState(this.updatePasswordModel);
}

class CustomerUpdatePasswordErrorState extends CustomerStates {
  final String error;
  CustomerUpdatePasswordErrorState(this.error);
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

class NotificationsState extends CustomerStates {}

class DeleteNotificationsState extends CustomerStates {}

class CustomerCartLoadedState extends CustomerStates {
  final List<Products> cartProducts;
  final double totalPrice;

  CustomerCartLoadedState(this.cartProducts, this.totalPrice);
}

final class GetCategoryDetailsLoadingState extends CustomerStates {}

final class GetCategoryDetailsSuccessState extends CustomerStates {
  final CategoryDetails? categoryDetails;

  GetCategoryDetailsSuccessState(this.categoryDetails);
}

final class GetCategoryDetailsErrorState extends CustomerStates {
  final String error;

  GetCategoryDetailsErrorState(this.error);
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

class GetCustomerOrdersLoadingState extends CustomerStates {}

class GetCustomerOrdersSuccessState extends CustomerStates {}

class GetCustomerOrdersErrorState extends CustomerStates {
  final String error;

  GetCustomerOrdersErrorState(this.error);
}
class AddToFavoritesLoadingState extends CustomerStates {}

class AddToFavoritesSuccessState extends CustomerStates {}

class AddToFavoritesErrorState extends CustomerStates {
  final String error;

  AddToFavoritesErrorState(this.error);
}
class RemoveFromFavoritesLoadingState extends CustomerStates {}

class RemoveFromFavoritesSuccessState extends CustomerStates {}

class RemoveFromFavoritesErrorState extends CustomerStates {
  final String error;

  RemoveFromFavoritesErrorState(this.error);
}
class GetFavoriteSellersLoadingState extends CustomerStates {}

class GetFavoriteSellersSuccessState extends CustomerStates {}

class GetFavoriteSellersErrorState extends CustomerStates {
  final String error;

  GetFavoriteSellersErrorState(this.error);
}
class CustomerRateSellersLoadingState extends CustomerStates {}

class CustomerRateSellersSuccessState extends CustomerStates {}

class CustomerRateSellersErrorState extends CustomerStates {
  final String error;

  CustomerRateSellersErrorState(this.error);
}
class GetCustomerOrderDetailsLoadingState extends CustomerStates {}

class GetCustomerOrderDetailsSuccessState extends CustomerStates {
  final OrderDetailsModel? orderDetailsModel;

  GetCustomerOrderDetailsSuccessState(this.orderDetailsModel);
}

class GetCustomerOrderDetailsErrorState extends CustomerStates {
  final String error;

  GetCustomerOrderDetailsErrorState(this.error);
}

class ContactUsLoadingState extends CustomerStates {}

class ContactUsSuccessState extends CustomerStates {
  final ContactUsModel contactUsModel;
  ContactUsSuccessState(this.contactUsModel);
}

class ContactUsErrorState extends CustomerStates {
  final String error;

  ContactUsErrorState(this.error);
}

class AboutAppLoadingState extends CustomerStates {}

class AboutAppSuccessState extends CustomerStates {}

class AboutAppErrorState extends CustomerStates {
  final String error;

  AboutAppErrorState(this.error);
}

class GetNotificationsLoadingState extends CustomerStates {}
class GetNotificationsSuccessState extends CustomerStates {}
class GetNotificationsErrorState extends CustomerStates {
  final String error;
  GetNotificationsErrorState(this.error);
}
class GetNotificationDetailsLoadingState extends CustomerStates {}
class GetNotificationDetailsSuccessState extends CustomerStates {
  final NotifiDetails notifiDetails;

  GetNotificationDetailsSuccessState(this.notifiDetails);
}
class GetNotificationDetailsErrorState extends CustomerStates {
  final String error;
  GetNotificationDetailsErrorState(this.error);
}
class GetHotDealsAndOffersLoadingState extends CustomerStates {}
class GetHotDealsAndOffersSuccessState extends CustomerStates {
}
class GetHotDealsAndOffersErrorState extends CustomerStates {
  final String error;
  GetHotDealsAndOffersErrorState(this.error);
}
class GetBestSalesLoadingState extends CustomerStates {}
class GetBestSalesSuccessState extends CustomerStates {
  final BestsaleModel? bestSalesModel;
  GetBestSalesSuccessState(this.bestSalesModel);
}
class GetBestSalesErrorState extends CustomerStates {
  final String error;
  GetBestSalesErrorState(this.error);
}
class GetTopDealsLoadingState extends CustomerStates {}
class GetTopDealsSuccessState extends CustomerStates {
  final BestsaleModel? bestSalesModel2;
  GetTopDealsSuccessState(this.bestSalesModel2);
}
class GetTopDealsErrorState extends CustomerStates {
  final String error;
  GetTopDealsErrorState(this.error);
}
class CheckoutLoadingState extends CustomerStates {}
class   CheckoutSuccessState extends CustomerStates {
  final CheckoutModel? checkoutModel;
  CheckoutSuccessState(this.checkoutModel);
}
class CheckoutErrorState extends CustomerStates {
  final String error;
  CheckoutErrorState(this.error);
}
class PaymentLoadingState extends CustomerStates {}
class   PaymentSuccessState extends CustomerStates {
}
class PaymentErrorState extends CustomerStates {
  final String error;
  PaymentErrorState(this.error);
}
