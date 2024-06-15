class SellerProducts {
  int? status;
  String? message;
  List<SellerProductData>? data;

  SellerProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SellerProductData>[];
      json['data'].forEach((v) {
        data!.add(SellerProductData.fromJson(v));
      });
    }
  }
}

class SellerProductData {
  int? id;
  String? name;
  String? price;
  String? discount;
  String? netPrice;
  List<String>? images;

  SellerProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    netPrice = json['net_price'];
    images = json['images'].cast<String>();
  }
}
