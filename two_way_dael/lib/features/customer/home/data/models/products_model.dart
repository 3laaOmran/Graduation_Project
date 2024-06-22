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
  Pagination? pagination;

  Data.fromJson(Map<String, dynamic> json) {
    productsCount = json['products_count'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
}

class Products {
  int? id;
  String? name;
  String? price;
  String? discount;
  String? netPrice;
  List<String>? images;
  int quantity=1;

  Products.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'],
        discount = json['discount'],
        netPrice = json['net_price'],
        images = List<String>.from(json['images'] ?? []);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'discount': discount,
      'net_price': netPrice,
      'images': images,
    };
  }
}

class Pagination {
  String? nextPageUrl;
  String? prevPageUrl;
  String? lastPageUrl;
  String? firstPageUrl;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? from;
  int? to;

  Pagination.fromJson(Map<String, dynamic> json) {
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
    lastPageUrl = json['last_page_url'];
    firstPageUrl = json['first_page_url'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    from = json['from'];
    to = json['to'];
  }
}
