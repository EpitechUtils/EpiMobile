// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fullSkillReportTests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullSkillReportTests _$FullSkillReportTestsFromJson(Map<String, dynamic> json) {
  return FullSkillReportTests(
      json['name'] as String,
      json['passed'] as bool,
      json['comment'] as String,
      json['crashed'] as bool,
      json['mandatory'] as bool);
}

Map<String, dynamic> _$FullSkillReportTestsToJson(
        FullSkillReportTests instance) =>
    <String, dynamic>{
      'name': instance.name,
      'passed': instance.passed,
      'crashed': instance.crashed,
      'mandatory': instance.mandatory,
      'comment': instance.comment
    };
