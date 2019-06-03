// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ModuleProjectGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleProjectGroup _$ModuleProjectGroupFromJson(Map<String, dynamic> json) {
  return ModuleProjectGroup(
      json['title'] as String,
      json['closed'] as bool,
      json['master'] == null
          ? null
          : ModuleProjectGroupMember.fromJson(
              json['master'] as Map<String, dynamic>),
      (json['members'] as List)
          ?.map((e) => e == null
              ? null
              : ModuleProjectGroupMember.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ModuleProjectGroupToJson(ModuleProjectGroup instance) =>
    <String, dynamic>{
      'title': instance.groupName,
      'closed': instance.closed,
      'master': instance.master,
      'members': instance.members
    };
