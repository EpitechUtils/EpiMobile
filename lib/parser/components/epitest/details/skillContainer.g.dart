// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skillContainer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillContainer _$SkillContainerFromJson(Map<String, dynamic> json) {
  return SkillContainer(json['FullSkillReport'] == null
      ? null
      : FullSkillReport.fromJson(
          json['FullSkillReport'] as Map<String, dynamic>));
}

Map<String, dynamic> _$SkillContainerToJson(SkillContainer instance) =>
    <String, dynamic>{'FullSkillReport': instance.fullSkillReport};
