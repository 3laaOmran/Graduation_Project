class ContactUsModel {
  int? status;
  String? message;
  Data? data;

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? name;
  String? email;
  String? subject;
  String? message;
  String? ipAddress;
  String? updatedAt;
  String? createdAt;
  int? id;


  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    subject = json['subject'];
    message = json['message'];
    ipAddress = json['ip_address'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}

class AboutAppModel {
  int? status;
  String? message;
  List<Data>? data;


  AboutAppModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class AbotAppData {
  int? id;
  String? title;
  String? copyright;
  String? description;
  Null phone;
  String? infoEmail;
  String? withdrawalEmail;
  String? supportEmail;
  String? logo;
  String? favicon;
  String? facebook;
  String? twitter;
  String? instagram;
  String? youtupe;
  String? tiktok;
  String? createdAt;
  String? updatedAt;


  AbotAppData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    copyright = json['copyright'];
    description = json['description'];
    phone = json['phone'];
    infoEmail = json['info_email'];
    withdrawalEmail = json['withdrawal_email'];
    supportEmail = json['support_email'];
    logo = json['logo'];
    favicon = json['favicon'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    youtupe = json['youtupe'];
    tiktok = json['tiktok'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}