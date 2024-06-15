class SellerProductDetails {
  int? status;
  String? message;
  ProductDetails? data;


  SellerProductDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProductDetails.fromJson(json['data']) : null;
  }

}

class ProductDetails {
  int? id;
  String? name;
  String? price;
  String? discount;
  String? netPrice;
  List<String>? images;
  String? description;
  String? availableFor;
  String? expiryDate;
  int? availableQuantity;
  Category? category;


  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    netPrice = json['net_price'];
    images = json['images'].cast<String>();
    description = json['description'];
    availableFor = json['available_for'];
    expiryDate = json['expire_date'];
    availableQuantity = json['available_quantity'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
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
