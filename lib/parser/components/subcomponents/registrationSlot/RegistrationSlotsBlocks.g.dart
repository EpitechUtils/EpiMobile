// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegistrationSlotsBlocks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationSlotsBlocks _$RegistrationSlotsBlocksFromJson(
    Map<String, dynamic> json) {
  return RegistrationSlotsBlocks(
      (json['slots'] as List)
          ?.map((e) => e == null
              ? null
              : RegistrationSlot.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['room'] as String,
      json['block_status'] as String);
}

Map<String, dynamic> _$RegistrationSlotsBlocksToJson(
        RegistrationSlotsBlocks instance) =>
    <String, dynamic>{
      'slots': instance.blocks,
      'block_status': instance.blockStatus,
      'room': instance.room
    };
