// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dashboard _$DashboardFromJson(Map<String, dynamic> json) {
  return Dashboard(json['projets'] as List, json['notes'] as List,
      json['modules'] as List, json['activites'] as List);
}

Map<String, dynamic> _$DashboardToJson(Dashboard instance) => <String, dynamic>{
      'projets': instance.projects,
      'notes': instance.marks,
      'activites': instance.activities,
      'modules': instance.modules
    };
