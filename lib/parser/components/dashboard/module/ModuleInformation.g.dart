// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ModuleInformation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleInformation _$ModuleInformationFromJson(Map<String, dynamic> json) {
  return ModuleInformation(
      json['scolaryear'] as String,
      (json['activites'] as List)
          ?.map((e) =>
              e == null ? null : Activity.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['description'] as String,
      json['end'] as String,
      json['title'] as String,
      json['semester'] as int,
      json['codeinstance'] as String,
      json['codemodule'] as String,
      json['begin'] as String,
      json['credits'] as int,
      json['end_register'] as String);
}

Map<String, dynamic> _$ModuleInformationToJson(ModuleInformation instance) =>
    <String, dynamic>{
      'scolaryear': instance.scolarYear,
      'codemodule': instance.codeModule,
      'codeinstance': instance.codeInstance,
      'semester': instance.semester,
      'title': instance.title,
      'begin': instance.begin,
      'end': instance.end,
      'end_register': instance.endRegister,
      'credits': instance.credits,
      'description': instance.description,
      'activites': instance.activites
    };
