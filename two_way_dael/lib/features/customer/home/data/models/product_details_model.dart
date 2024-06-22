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
  String? price;
  String? discount;
  String? netPrice;
  List<String>? images;
  String? description;
  String? availableFor;
  String? expireDate;
  int? availableQuantity;
  Category? category;
  Store? store;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    netPrice = json['net_price'];
    images = json['images']?.cast<String>();
    description = json['description'];
    availableFor = json['available_for'];
    expireDate = json['expire_date'];
    availableQuantity = json['available_quantity'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
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

class Store {
  int? id;
  String? name;
  String? address;
  String? image;
  String? rate;
  String? rateWithReviews;
  String? phone;
  List<Products>? customersellerProducts;

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    image = json['image'];
    rate = json['rate'];
    rateWithReviews = json['rate_with_reviews'];
    phone = json['phone'];
    if (json['products'] != null) {
      customersellerProducts = <Products>[];
      json['products'].forEach((v) {
        customersellerProducts!.add(Products.fromJson(v));
      });
    }
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
