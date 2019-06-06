// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ModuleProjectGroupMember.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleProjectGroupMember _$ModuleProjectGroupMemberFromJson(
    Map<String, dynamic> json) {
  return ModuleProjectGroupMember(
      json['title'] as String,
      json['picture'] as String,
      json['status'] as String,
      json['login'] as String);
}

Map<String, dynamic> _$ModuleProjectGroupMemberToJson(
        ModuleProjectGroupMember instance) =>
    <String, dynamic>{
      'title': instance.name,
      'picture': instance.picture,
      'status': instance.status,
      'login': instance.login
    };
