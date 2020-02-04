// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegistrationSlots.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationSlots _$RegistrationSlotsFromJson(Map<String, dynamic> json) {
  return RegistrationSlots(
      (json['slots'] as List)
          ?.map((e) => e == null
              ? null
              : RegistrationSlotsBlocks.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['group'] == null
          ? null
          : RegistrationSlotGroup.fromJson(
              json['group'] as Map<String, dynamic>));
}

Map<String, dynamic> _$RegistrationSlotsToJson(RegistrationSlots instance) =>
    <String, dynamic>{'slots': instance.slots, 'group': instance.group};
