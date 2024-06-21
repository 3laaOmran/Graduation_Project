import 'package:two_way_dael/features/customer/home/data/models/products_model.dart';

class OrderDetailsModel {
  int? status;
  String? message;
  Data? data;


  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? id;
  String? status;
  String? icon;
  String? iconColor;
  String? netPrice;
  String? orderedFrom;
  bool? shipping;
  String? totalPrice;
  String? shippingPrice;
  String? paymentMethod;
  String? address;
  String? phone;
  List<Products>? products;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    icon = json['icon'];
    iconColor = json['icon_color'];
    netPrice = json['net_price'];
    orderedFrom = json['ordered_from'];
    shipping = json['shipping'];
    totalPrice = json['total_price'];
    shippingPrice = json['shipping_price'];
    paymentMethod = json['payment_method'];
    address = json['address'];
    phone = json['phone'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

}
