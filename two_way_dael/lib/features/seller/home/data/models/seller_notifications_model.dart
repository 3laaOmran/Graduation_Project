// class NotificationsModel {
//   int? status;
//   String? message;
//   Data? data;

//   NotificationsModel({this.status, this.message, this.data});

//   NotificationsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }

// }

// class Data {
//   int? count;
//   List<Notifications>? notifications;


//   Data.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     if (json['notifications'] != null) {
//       notifications = <Notifications>[];
//       json['notifications'].forEach((v) {
//         notifications!.add(Notifications.fromJson(v));
//       });
//     }
//   }

// }

// class Notifications {
//   int? id;
//   String? title;
//   String? createdAt;


//   Notifications.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     createdAt = json['created_at'];
//   }

// }
// //*------------------------------------------------

// class NotificationDetails {
//   int? status;
//   String? message;
//   NotificationData? notificationData;


//   NotificationDetails.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     notificationData = json['data'] != null ? NotificationData.fromJson(json['data']) : null;
//   }
// }

// class NotificationData {
//   int? id;
//   String? title;
//   String? createdAt;
//   String? lastUpdated;
//   String? body;


//   NotificationData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     createdAt = json['created_at'];
//     lastUpdated = json['last_updated'];
//     body = json['body'];
//   }

// }


class NotificationsModel {
  int? status;
  String? message;
  List<Notifications>? data;


  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Notifications>[];
      json['data'].forEach((v) {
        data!.add(Notifications.fromJson(v));
      });
    }
  }

}

class Notifications {
  String? id;
  String? title;
  String? createdAt;
  bool? isRead;


  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    isRead = json['is_read'];
  }

}
 //*--------------------------------
 class NotificationDetails {
  int? status;
  String? message;
  NotificationData? data;


  NotificationDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new NotificationData.fromJson(json['data']) : null;
  }

}

class NotificationData {
  String? id;
  String? title;
  String? createdAt;
  bool? isRead;
  String? readAt;
  String? lastUpdated;
  String? content;


  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    isRead = json['is_read'];
    readAt = json['read_at'];
    lastUpdated = json['last_updated'];
    content = json['content'];
  }
}

