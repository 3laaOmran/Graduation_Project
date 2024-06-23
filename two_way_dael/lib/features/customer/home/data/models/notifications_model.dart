class NotificationsModel {
  int? status;
  String? message;
  List<Data>? data;


  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

}

class Data {
  String? id;
  String? title;
  String? createdAt;
  bool? isRead;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    isRead = json['is_read'];
  }

}
 //*--------------------------------
 class NotifiDetails {
  int? status;
  String? message;
  NotifiData? data;


  NotifiDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new NotifiData.fromJson(json['data']) : null;
  }

}

class NotifiData {
  String? id;
  String? title;
  String? createdAt;
  bool? isRead;
  String? readAt;
  String? lastUpdated;
  String? content;


  NotifiData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    isRead = json['is_read'];
    readAt = json['read_at'];
    lastUpdated = json['last_updated'];
    content = json['content'];
  }
}
