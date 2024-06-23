class FavoritesModel {
  int? status;
  String? message;
  List<FavoritesData>? data;

  FavoritesModel({this.status, this.message, this.data});

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FavoritesData>[];
      json['data'].forEach((v) {
        data!.add(FavoritesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

  class FavoritesData {
  int? id;
  String? name;
  String? phone;
  String? address;
  int? sellerId;
  bool? isFavourite;
  String? image;
  String? rate;
  String? rateWithReviews;


  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    sellerId = json['seller_id'];
    isFavourite = json['is_favourite'];
    image = json['image'];
    rate = json['rate'];
    rateWithReviews = json['rate_with_reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['seller_id'] = sellerId;
    data['is_favourite'] = isFavourite;
    data['image'] = image;
    data['rate'] = rate;
    data['rate_with_reviews'] = rateWithReviews;
    return data;
  }
}