class CheckoutModel {
  int? status;
  String? message;
  Data? data;


  CheckoutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? orderId;
  int? invoiceId;
  int? totalPrice;


  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    invoiceId = json['invoice_id'];
    totalPrice = json['total_price'];
  }

}
