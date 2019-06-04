// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Notifications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notifications _$NotificationsFromJson(Map<String, dynamic> json) {
  return Notifications((json['history'] as List)
      ?.map((e) =>
          e == null ? null : Notification.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$NotificationsToJson(Notifications instance) =>
    <String, dynamic>{'history': instance.notifications};
