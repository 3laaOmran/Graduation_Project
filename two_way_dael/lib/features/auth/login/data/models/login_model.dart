class LoginModel {
  int? status;
  String? message;
  UserData? data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  String? token;
  
  UserData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
}


// class LoginErrorModel {
//   int? status;
//   String? message;
//   UserData? data;

//   LoginErrorModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? UserData.fromJson(json['data']) : null;
//   }
// }

// class ErrorData {
//   String? email;
  
//   ErrorData.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//   }
// }
