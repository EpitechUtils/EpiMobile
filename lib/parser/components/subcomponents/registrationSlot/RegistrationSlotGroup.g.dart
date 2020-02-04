// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegistrationSlotGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationSlotGroup _$RegistrationSlotGroupFromJson(
    Map<String, dynamic> json) {
  return RegistrationSlotGroup(
      json['title'] as String,
      json['id'] as int,
      (json['members'] as List)?.map((e) => e as String)?.toList(),
      json['master'] as String);
}

Map<String, dynamic> _$RegistrationSlotGroupToJson(
        RegistrationSlotGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'master': instance.master,
      'members': instance.members
    };
