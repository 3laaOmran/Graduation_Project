
// class GovernoratesModel {
//   int? status;
//   String? message;
//   List<Data>? data;

//   GovernoratesModel({this.status, this.message, this.data});

//   GovernoratesModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'] as int?;
//     message = json['message'] as String?;
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v as Map<String, dynamic>));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String name = '';

//   Data({this.id, required this.name});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'] as int?;
//     name = json['name'] as String;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     return data;
//   }
// }


// //---------------------------------------

// class CityModel {
//   int? status;
//   String? message;
//   List<Data>? data;

//   CityModel({this.status, this.message, this.data});

//   CityModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'] as int?;
//     message = json['message'] as String?;
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v as Map<String, dynamic>));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
