// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subResults.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubResults _$SubResultsFromJson(Map<String, dynamic> json) {
  return SubResults(
      (json['logins'] as List)?.map((e) => e as String)?.toList(),
      json['mandatoryFailed'] as int,
      json['mark'] as String,
      (json['externalItems'] as List)
          ?.map((e) => e == null
              ? null
              : ResultsExternalItems.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['prerequisites'] as int,
      (json['skills'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(
            k,
            e == null
                ? null
                : ResultsSkill.fromJson(e as Map<String, dynamic>)),
      ));
}

Map<String, dynamic> _$SubResultsToJson(SubResults instance) =>
    <String, dynamic>{
      'logins': instance.logins,
      'prerequisites': instance.prerequisites,
      'skills': instance.skills,
      'mark': instance.mark,
      'mandatoryFailed': instance.mandatoryFailed,
      'externalItems': instance.externalItems
    };
