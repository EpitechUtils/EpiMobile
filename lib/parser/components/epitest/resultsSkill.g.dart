// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultsSkill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultsSkill _$ResultsSkillFromJson(Map<String, dynamic> json) {
  return ResultsSkill(json['count'] as int, json['crashed'] as int,
      json['mandatoryFailed'] as int, json['passed'] as int);
}

Map<String, dynamic> _$ResultsSkillToJson(ResultsSkill instance) =>
    <String, dynamic>{
      'count': instance.count,
      'passed': instance.passed,
      'crashed': instance.crashed,
      'mandatoryFailed': instance.mandatoryFailed
    };
