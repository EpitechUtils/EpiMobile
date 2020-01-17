// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileMark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileMark _$ProfileMarkFromJson(Map<String, dynamic> json) {
  return ProfileMark(
      json['title'] as String,
      json['date'] as String,
      (json['final_note'] as num)?.toDouble(),
      json['scolaryear'] as int,
      json['codemodule'] as String);
}

Map<String, dynamic> _$ProfileMarkToJson(ProfileMark instance) =>
    <String, dynamic>{
      'title': instance.name,
      'date': instance.date,
      'final_note': instance.mark,
      'scolaryear': instance.scolarYear,
      'codemodule': instance.codeModule
    };
