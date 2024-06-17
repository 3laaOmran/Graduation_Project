class UpdatePasswordModel {
  int? status;
  String? message;

  UpdatePasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}