// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return Activity(
      json['title'] as String,
      json['module'] as String,
      json['module_link'] as String,
      json['module_code'] as String,
      json['title_link'] as String,
      json['timeline_start'] as String,
      json['timeline_end'] as String,
      json['timeline_barre'] as String,
      json['salle'] as String,
      json['intervenant'] as String,
      json['date_inscription'],
      json['register_link'] as String);
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'title': instance.name,
      'module': instance.module,
      'module_link': instance.moduleLink,
      'module_code': instance.moduleCode,
      'title_link': instance.titleLink,
      'timeline_start': instance.timelineStart,
      'timeline_end': instance.timelineEnd,
      'timeline_barre': instance.timelineBarre,
      'salle': instance.room,
      'intervenant': instance.teacher,
      'date_inscription': instance.inscriptionDate,
      'register_link': instance.registerLink
    };
