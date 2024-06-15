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
  String? price;
  String? discount;
  String? netPrice;
  List<String>? images;
  int quantity = 1; // Add this field

  Products({
    this.name,
    this.price,
    this.images,
    this.quantity = 1, // Default quantity to 1
  });
  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price =
        (json['price'] ); 
    discount = json['discount'];
    netPrice = json['net_price'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['images'] = images;
    return data;
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