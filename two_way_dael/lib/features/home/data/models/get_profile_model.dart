// class UserModel {
//   int? status;
//   String? message;
//   UserData? data;
//   UserModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? UserData.fromJson(json['data']) : null;
//   }
// }

// class UserData {
//   String? name;
//   String? email;
//   int? phone;
//   UserData.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//   }
// }
class UserDataModel {
  int? status;
  String? message;
  Data? data;


  UserDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? profilePicture;
  String? phone;
  String? joinedFrom;
  String? governorate;
  String? city;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profilePicture = json['profile_picture'];
    phone = json['phone'];
    joinedFrom = json['joined_from'];
    governorate = json['governorate'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['profile_picture'] = profilePicture;
    data['phone'] = phone;
    data['joined_from'] = joinedFrom;
    return data;
  }
}




// class ShopLoginModel
// {
//   bool status;
//   String message;
//   UserData data;

//   ShopLoginModel.fromJson(Map<String, dynamic> json)
//   {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? UserData.fromJson(json['data']) : null;
//   }
// }

// class UserData
// {
//   int id;
//   String name;
//   String email;
//   String phone;
//   String image;
//   int points;
//   int credit;
//   String token;

//   UserData.fromJson(Map<String, dynamic> json)
//   {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     image = json['image'];
//     points = json['points'];
//     credit = json['credit'];
//     token = json['token'];
//   }
// }
