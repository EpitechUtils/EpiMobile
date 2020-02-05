// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
      json['project'] == null
          ? null
          : ResultProject.fromJson(json['project'] as Map<String, dynamic>),
      json['date'] as String,
      json['module'] == null
          ? null
          : ResultModule.fromJson(json['module'] as Map<String, dynamic>),
      json['results'] == null
          ? null
          : SubResults.fromJson(json['results'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'project': instance.project,
      'module': instance.module,
      'results': instance.results,
      'date': instance.date
    };
