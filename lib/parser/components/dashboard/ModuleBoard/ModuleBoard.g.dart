// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ModuleBoard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleBoard _$ModuleBoardFromJson(Map<String, dynamic> json) {
  return ModuleBoard((json['modules'] as List)
      ?.map((e) =>
          e == null ? null : BoardModule.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$ModuleBoardToJson(ModuleBoard instance) =>
    <String, dynamic>{'modules': instance.modules};
