// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
      json['timeline_end'] as String,
      json['date_inscription'],
      json['title'] as String,
      json['timeline_start'] as String,
      json['timeline_barre'] as String,
      json['title_link'] as String,
      json['id_activite'] as String);
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'title': instance.name,
      'title_link': instance.urlLink,
      'timeline_start': instance.startDate,
      'timeline_end': instance.endDate,
      'timeline_barre': instance.timeline,
      'date_inscription': instance.inscriptionDate,
      'id_activite': instance.id
    };
