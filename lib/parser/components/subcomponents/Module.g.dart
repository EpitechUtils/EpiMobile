// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Module _$ModuleFromJson(Map<String, dynamic> json) {
  return Module(
      json['title'] as String,
      json['title_link'] as String,
      json['timeline_start'] as String,
      json['timeline_end'] as String,
      json['timeline_barre'] as String,
      json['date_inscription']);
}

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
      'title': instance.name,
      'title_link': instance.titleLink,
      'timeline_start': instance.timelineStart,
      'timeline_end': instance.timelineEnd,
      'timeline_barre': instance.timelineBarre,
      'date_inscription': instance.inscriptionDate
    };
