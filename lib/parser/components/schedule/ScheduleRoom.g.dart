// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScheduleRoom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleRoom _$ScheduleRoomFromJson(Map<String, dynamic> json) {
  return ScheduleRoom(
      json['type'] as String, json['code'] as String, json['seats'] as int);
}

Map<String, dynamic> _$ScheduleRoomToJson(ScheduleRoom instance) =>
    <String, dynamic>{
      'code': instance.code,
      'type': instance.type,
      'seats': instance.seats
    };
