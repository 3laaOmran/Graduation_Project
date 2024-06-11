part of 'seller_cubit.dart';

@immutable
sealed class SellerStates {}

final class SellerInitial extends SellerStates {}
final class SellerChangeBottomNavState extends SellerStates {}
class SellerNotificationsState extends SellerStates {}

class SellerDeleteNotificationsState extends SellerStates {}
