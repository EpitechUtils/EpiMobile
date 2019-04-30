// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Module _$ModuleFromJson(Map<String, dynamic> json) {
  return Module(
      json['title'] as String,
      json['title_link'] as String,
      json['timeline_start'] == null
          ? null
          : DateTime.parse(json['timeline_start'] as String),
      json['timeline_end'] == null
          ? null
          : DateTime.parse(json['timeline_end'] as String),
      json['timeline_barre'] as String,
      json['date_inscription']);
}

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
      'title': instance.name,
      'title_link': instance.titleLink,
      'timeline_start': instance.timelineStart?.toIso8601String(),
      'timeline_end': instance.timelineEnd?.toIso8601String(),
      'timeline_barre': instance.timelineBarre,
      'date_inscription': instance.inscriptionDate
    };
