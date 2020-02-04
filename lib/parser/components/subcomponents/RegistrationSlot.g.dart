// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegistrationSlot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationSlot _$RegistrationSlotFromJson(Map<String, dynamic> json) {
  return RegistrationSlot(
      json['title'] as String,
      json['duration'] as int,
      json['date'] as String,
      json['status'] as String,
      json['master'] == null
          ? null
          : RegistrationSlotMember.fromJson(
              json['master'] as Map<String, dynamic>),
      (json['members'] as List)
          ?.map((e) => e == null
              ? null
              : RegistrationSlotMember.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['bloc_status'] as String,
      json['id_team'] as String,
      json['members_pictures'] as String);
}

Map<String, dynamic> _$RegistrationSlotToJson(RegistrationSlot instance) =>
    <String, dynamic>{
      'date': instance.date,
      'duration': instance.duration,
      'status': instance.status,
      'bloc_status': instance.blockStatus,
      'id_team': instance.idTeam,
      'title': instance.title,
      'members_pictures': instance.membersPictures,
      'master': instance.master,
      'members': instance.members
    };
