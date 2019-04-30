// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DashboardBoard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Board _$BoardFromJson(Map<String, dynamic> json) {
  return Board(
      (json['projets'] as List)
          ?.map((e) =>
              e == null ? null : Project.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['notes'] as List)
          ?.map((e) =>
              e == null ? null : Marks.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'projets': instance.projects,
      'notes': instance.marks,
      'activites': instance.activities,
      'modules': instance.modules
    };
