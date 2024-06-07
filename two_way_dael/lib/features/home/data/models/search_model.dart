// import 'package:two_way_dael/features/home/data/models/products_model.dart';

// // class SearchModel {
// //   int? status;
// //   String? message;
// //   Data? data;

// //   SearchModel.fromJson(Map<String, dynamic> json) {
// //     status = json['status'];
// //     message = json['message'];
// //     data = json['data'] != null ? Data.fromJson(json['data']) : null;
// //   }
// // }

// class Data {
//   int? productsCount;
//   List<Products>? products;

//   Data.fromJson(Map<String, dynamic> json) {
//     productsCount = json['products_count'];
//     if (json['products'] != null) {
//       products = <Products>[];
//       json['products'].forEach((v) {
//         products!.add(Products.fromJson(v));
//       });
//     }
//   }
// }

// // class Products {
// //   int? id;
// //   String? name;
// //   double? price;
// //   String? discount;
// //   String? netPrice;
// //   List<String>? images;

// //   Products.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     name = json['name'];
// //     price = json['price'];
// //     discount = json['discount'];
// //     netPrice = json['net_price'];
// //     images = json['images'].cast<String>();
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['id'] = id;
// //     data['name'] = name;
// //     data['price'] = price;
// //     data['discount'] = discount;
// //     data['net_price'] = netPrice;
// //     data['images'] = images;
// //     return data;
// //   }
// // }