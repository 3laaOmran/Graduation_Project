class ProductsModel {
  int? status;
  String? message;
  Data? data;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? productsCount;
  List<Products>? products;

  Data.fromJson(Map<String, dynamic> json) {
    productsCount = json['products_count'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }
}
class Products {
  int? id;
  String? name;
  double? price;
  String? discount;
  String? netPrice;
  List<String>? images;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = (json['price'] as num?)?.toDouble();  // Convert to double if it's an int
    discount = json['discount'];
    netPrice = json['net_price'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }
}

// class Products {
//   int? id;
//   String? name;
//   double? price;
//   String? discount;
//   String? netPrice;
//   List<String>? images;

//   Products.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     price = json['price'];
//     discount = json['discount'];
//     netPrice = json['net_price'];
//     images = json['images'] != null ? json['images'].cast<String>() : [];
//   }
// }