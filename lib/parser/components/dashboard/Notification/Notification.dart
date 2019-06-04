import 'package:json_annotation/json_annotation.dart';
import 'UserNotification.dart';

part 'Notification.g.dart';

@JsonSerializable()
class Notification {
    String title;
    String content;
    String date;
    String id;
    @JsonKey(name: "id_activite")
    String activityId;
    UserNotification user;

    /// Notifications Ctor
    Notification(this.title, this.content, this.date, this.id, this.activityId, this.user);

    /// Notifications fromJson serialization method
    factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

    /// Notifications toJson serialization method
    Map<String, dynamic> toJson() => _$NotificationToJson(this);
}