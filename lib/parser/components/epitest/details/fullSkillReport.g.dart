// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fullSkillReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullSkillReport _$FullSkillReportFromJson(Map<String, dynamic> json) {
  return FullSkillReport(
      json['name'] as String,
      (json['tests'] as List)
          ?.map((e) => e == null
              ? null
              : FullSkillReportTests.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$FullSkillReportToJson(FullSkillReport instance) =>
    <String, dynamic>{'name': instance.name, 'tests': instance.tests};
