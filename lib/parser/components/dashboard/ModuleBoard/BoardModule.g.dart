// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BoardModule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardModule _$BoardModuleFromJson(Map<String, dynamic> json) {
  return BoardModule(
      json['codeinstance'] as String,
      json['project'] as String,
      json['title_module'] as String,
      json['begin_acti'] as String,
      json['begin_event'],
      json['codemodule'] as String,
      json['end_acti'] as String,
      json['end_event'],
      json['registered'] as int,
      json['type_acti_code'] as String);
}

Map<String, dynamic> _$BoardModuleToJson(BoardModule instance) =>
    <String, dynamic>{
      'title_module': instance.moduleName,
      'codemodule': instance.codeModule,
      'codeinstance': instance.codeInstance,
      'begin_event': instance.beginEvent,
      'end_event': instance.endEvent,
      'type_acti_code': instance.type,
      'begin_acti': instance.beginActivity,
      'end_acti': instance.endActivity,
      'registered': instance.registered,
      'project': instance.name
    };
