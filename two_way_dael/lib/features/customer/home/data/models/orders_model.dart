class CustomerOrdersModel {
  int? status;
  String? message;
  Data? data;

  CustomerOrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? ordersCount;
  List<Orders>? orders;

  Data.fromJson(Map<String, dynamic> json) {
    ordersCount = json['orders_count'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }
}

class Orders {
  int? id;
  String? status;
  String? netPrice;
  String? orderedFrom;
  String? icon;
  String? iconColor;

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    netPrice = json['net_price'];
    orderedFrom = json['ordered_from'];
    icon = json['icon'];
    iconColor = json['icon_color'];
  }
}
