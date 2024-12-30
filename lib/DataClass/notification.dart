import 'package:json_annotation/json_annotation.dart';
import 'package:pickcar/DataClass/user.dart';

@JsonSerializable()
class Notification {
  String? notificationIdentifier;
  String? type;
  String? title;
  String? notificationData;
  User? user;

  Notification({
    required this.notificationIdentifier,
    required this.type,
    required this.title,
    required this.notificationData,
    required this.user,
  });

  factory Notification.fromJson(Map<String, dynamic>? json) {
    return Notification(
      notificationIdentifier: json?['notificationIdentifier'] as String?,
      type: json?['type'] as String?,
      title: json?['title'] as String?,
      notificationData: json?['notificationData'] as String?,
      user: json != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic>? toJson() {
    return {
      'notificationIdentifier': notificationIdentifier,
      'type': type,
      'title': title,
      'notificationData': notificationData,
      'user': user?.toJson(),
    };
  }
}
