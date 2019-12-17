// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileMark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileMark _$ProfileMarkFromJson(Map<String, dynamic> json) {
  return ProfileMark(json['title'] as String, json['title_link'] as String,
      json['note'] as String, json['noteur'] as String);
}

Map<String, dynamic> _$ProfileMarkToJson(ProfileMark instance) =>
    <String, dynamic>{
      'title': instance.name,
      'title_link': instance.urlLink,
      'note': instance.mark,
      'noteur': instance.markAuthor
    };
