// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
      json['timeline_end'] == null
          ? null
          : DateTime.parse(json['timeline_end'] as String),
      json['date_inscription'] == null
          ? null
          : DateTime.parse(json['date_inscription'] as String),
      json['title'] as String,
      json['timeline_start'] == null
          ? null
          : DateTime.parse(json['timeline_start'] as String),
      (json['timeline_barre'] as num)?.toDouble(),
      json['title_link'] as String,
      json['id_activite'] as String);
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'title': instance.name,
      'title_link': instance.urlLink,
      'timeline_start': instance.startDate?.toIso8601String(),
      'timeline_end': instance.endDate?.toIso8601String(),
      'timeline_barre': instance.timeline,
      'date_inscription': instance.inscriptionDate?.toIso8601String(),
      'id_activite': instance.id
    };
