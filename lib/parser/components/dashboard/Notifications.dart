import 'package:json_annotation/json_annotation.dart';
import 'Notification/Notification.dart';

part 'Notifications.g.dart';

@JsonSerializable()
class Notifications {
    @JsonKey(name: "history")
    List<Notification> notifications;

    /// Notifications Ctor
    Notifications(this.notifications);

    /// Notifications fromJson serialization method
    factory Notifications.fromJson(Map<String, dynamic> json) => _$NotificationsFromJson(json);

    /// Notifications toJson serialization method
    Map<String, dynamic> toJson() => _$NotificationsToJson(this);
}