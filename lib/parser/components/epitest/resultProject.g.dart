// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultProject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultProject _$ResultProjectFromJson(Map<String, dynamic> json) {
  return ResultProject(
      json['slug'] as String,
      json['name'] as String,
      json['module'] == null
          ? null
          : ResultModule.fromJson(json['module'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ResultProjectToJson(ResultProject instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'name': instance.name,
      'module': instance.module
    };
