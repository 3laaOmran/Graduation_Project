class CategoryDetails {
  int? status;
  String? message;
  Data? data;

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  String? description;
  int? productsCount;
  List<CategoryProducts>? products;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    productsCount = json['products_count'];
    if (json['products'] != null) {
      products = <CategoryProducts>[];
      json['products'].forEach((v) {
        products!.add(CategoryProducts.fromJson(v));
      });
    }
  }
}

class CategoryProducts {
  int? id;
  String? name;
  String? price;
  String? discount;
  String? netPrice;
  List<String>? images;

  CategoryProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    netPrice = json['net_price'];
    images = json['images'].cast<String>();
  }
}