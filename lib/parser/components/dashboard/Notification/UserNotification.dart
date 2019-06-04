import 'package:json_annotation/json_annotation.dart';

part 'UserNotification.g.dart';

@JsonSerializable()
class UserNotification {
    String picture;
    @JsonKey(name: "title")
    String name;

    /// Notifications Ctor
    UserNotification(this.picture, this.name);

    /// Notifications fromJson serialization method
    factory UserNotification.fromJson(Map<String, dynamic> json) => _$UserNotificationFromJson(json);

    /// Notifications toJson serialization method
    Map<String, dynamic> toJson() => _$UserNotificationToJson(this);
}