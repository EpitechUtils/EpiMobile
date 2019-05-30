// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Mark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mark _$MarkFromJson(Map<String, dynamic> json) {
  return Mark(
      json['title'] as String,
      json['title_link'] as String,
      json['note'] == null ? null : DateTime.parse(json['note'] as String),
      json['noteur'] == null ? null : DateTime.parse(json['noteur'] as String));
}

Map<String, dynamic> _$MarkToJson(Mark instance) => <String, dynamic>{
      'title': instance.name,
      'title_link': instance.urlLink,
      'note': instance.mark?.toIso8601String(),
      'noteur': instance.markAuthor?.toIso8601String()
    };
