// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScheduleDay.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDay _$ScheduleDayFromJson(Map<String, dynamic> json) {
  return ScheduleDay((json['sessions'] as List)
      ?.map((e) => e == null
          ? null
          : ScheduleSession.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$ScheduleDayToJson(ScheduleDay instance) =>
    <String, dynamic>{'sessions': instance.sessions};
