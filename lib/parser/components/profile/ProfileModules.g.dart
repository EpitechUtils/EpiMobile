// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileModules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModules _$ProfileModulesFromJson(Map<String, dynamic> json) {
  return ProfileModules(
      json['codeinstance'] as String,
      json['codemodule'] as String,
      json['title'] as String,
      json['scolaryear'] as int,
      json['credits'] as int,
      json['grade'] as String);
}

Map<String, dynamic> _$ProfileModulesToJson(ProfileModules instance) =>
    <String, dynamic>{
      'scolaryear': instance.scolarYear,
      'title': instance.title,
      'credits': instance.credits,
      'grade': instance.grade,
      'codemodule': instance.codeModule,
      'codeinstance': instance.codeInstance
    };
