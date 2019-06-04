// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return Notification(
      json['title'] as String,
      json['content'] as String,
      json['date'] as String,
      json['id'] as String,
      json['id_activite'] as String,
      json['user'] == null
          ? null
          : UserNotification.fromJson(json['user'] as Map<String, dynamic>));
}

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'date': instance.date,
      'id': instance.id,
      'id_activite': instance.activityId,
      'user': instance.user
    };
