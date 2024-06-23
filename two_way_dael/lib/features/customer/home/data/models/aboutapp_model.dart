

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

class Data {
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


  Data.fromJson(Map<String, dynamic> json) {
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