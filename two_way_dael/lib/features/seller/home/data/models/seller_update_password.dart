class SellerUpdatePasswordModel {
  int? status;
  String? message;

  SellerUpdatePasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}