// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dashboard _$DashboardFromJson(Map<String, dynamic> json) {
  return Dashboard(
      (json['projets'] as List)
          ?.map((e) =>
              e == null ? null : Project.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['notes'] as List)
          ?.map((e) =>
              e == null ? null : Mark.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['activites'] as List)
          ?.map((e) =>
              e == null ? null : Activity.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['modules'] as List)
          ?.map((e) =>
              e == null ? null : Module.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DashboardToJson(Dashboard instance) => <String, dynamic>{
      'projets': instance.projects,
      'notes': instance.marks,
      'activites': instance.activities,
      'modules': instance.modules
    };
