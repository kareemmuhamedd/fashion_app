import 'dart:convert';

NotificationCountModel notificationCountModelFromJson(String str) => NotificationCountModel.fromJson(json.decode(str));

String notificationCountModelToJson(NotificationCountModel data) => json.encode(data.toJson());

class NotificationCountModel {
  final int unreadCount;

  NotificationCountModel({
    required this.unreadCount,
  });

  factory NotificationCountModel.fromJson(Map<String, dynamic> json) => NotificationCountModel(
    unreadCount: json["unread_count"],
  );

  Map<String, dynamic> toJson() => {
    "unread_count": unreadCount,
  };
}
