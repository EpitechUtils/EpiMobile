// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegistrationSlots.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationSlots _$RegistrationSlotsFromJson(Map<String, dynamic> json) {
  return RegistrationSlots((json['slots'] as List)
      ?.map((e) => e == null
          ? null
          : RegistrationSlot.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$RegistrationSlotsToJson(RegistrationSlots instance) =>
    <String, dynamic>{'slots': instance.slots};
