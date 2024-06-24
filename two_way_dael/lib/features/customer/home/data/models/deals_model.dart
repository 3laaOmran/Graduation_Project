
import 'package:two_way_dael/features/customer/home/data/models/products_model.dart';

class Deals {
  int? status;
  String? message;
  Data? data;

  Deals.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  Bestsale? bestsale;
  Bestsale? topdeals;

  Data.fromJson(Map<String, dynamic> json) {
    bestsale = json['bestsale'] != null
        ? new Bestsale.fromJson(json['bestsale'])
        : null;
    topdeals = json['topdeals'] != null
        ? new Bestsale.fromJson(json['topdeals'])
        : null;
  }
}

class Bestsale {
  int? id;
  String? image;

  Bestsale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class BestsaleModel {
  int? status;
  String? message;
  List<Products>? data;


  BestsaleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Products>[];
      json['data'].forEach((v) {
        data!.add( Products.fromJson(v));
      });
    }
  }

}

