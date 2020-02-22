// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skillDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillDetails _$SkillDetailsFromJson(Map<String, dynamic> json) {
  return SkillDetails((json['skills'] as List)
      ?.map((e) =>
          e == null ? null : SkillContainer.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$SkillDetailsToJson(SkillDetails instance) =>
    <String, dynamic>{'skills': instance.skills};
