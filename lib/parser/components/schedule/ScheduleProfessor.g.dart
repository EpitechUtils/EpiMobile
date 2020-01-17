// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScheduleProfessor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleProfessor _$ScheduleProfessorFromJson(Map<String, dynamic> json) {
  return ScheduleProfessor(
      json['type'] as String, json['title'] as String, json['login'] as String);
}

Map<String, dynamic> _$ScheduleProfessorToJson(ScheduleProfessor instance) =>
    <String, dynamic>{
      'type': instance.type,
      'login': instance.login,
      'title': instance.title
    };
