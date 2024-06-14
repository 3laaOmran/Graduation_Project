import 'package:two_way_dael/features/customer/home/data/models/products_model.dart';

class ProductDetails {
  int? status;
  String? message;
  Data? data;

  ProductDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  Product? product;
  List<Products>? similarProducts;

  Data.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['similar_products'] != null) {
      similarProducts = <Products>[];
      json['similar_products'].forEach((v) {
        similarProducts!.add(Products.fromJson(v));
      });
    }
  }
}

class Product {
  int? id;
  String? name;
  double? price;
  String? discount;
  String? netPrice;
  List<String>? images;
  String? description;
  String? availableFor;
  String? expireDate;
  int? availableQuantity;
  Category? category;
  Category? store;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // Check if price is int or double and assign accordingly
    price = (json['price'] is int)
        ? (json['price'] as int).toDouble()
        : json['price'];
    discount = json['discount'];
    netPrice = json['net_price'];
    images = json['images']?.cast<String>();
    description = json['description'];
    availableFor = json['available_for'];
    expireDate = json['expire_date'];
    availableQuantity = json['available_quantity'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    store = json['store'] != null ? Category.fromJson(json['store']) : null;
  }
}

class Category {
  int? id;
  String? name;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

// class SimilarProductsModel {
//   int? status;
//   String? message;
//   Product? product;
//   List<Products>? similarProducts;

//   SimilarProductsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     product = json['data']['product'] != null ? Product.fromJson(json['data']['product']) : null;
//     if (json['data']['similar_products'] != null) {
//       similarProducts = <Products>[];
//       json['data']['similar_products'].forEach((v) {
//         similarProducts!.add(Products.fromJson(v));
//       });
//     }
//   }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['status'] = status;
  //   data['message'] = message;
  //   if (product != null) {
  //     data['product'] = product!.toJson();
  //   }
  //   if (similarProducts != null) {
  //     data['similar_products'] = similarProducts!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
  // }
