// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegistrationSlotMember.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationSlotMember _$RegistrationSlotMemberFromJson(
    Map<String, dynamic> json) {
  return RegistrationSlotMember(json['title'] as String,
      json['login'] as String, json['picture'] as String);
}

Map<String, dynamic> _$RegistrationSlotMemberToJson(
        RegistrationSlotMember instance) =>
    <String, dynamic>{
      'login': instance.login,
      'title': instance.title,
      'picture': instance.picture
    };
