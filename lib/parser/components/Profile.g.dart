// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
      json['firstname'] as String,
      json['lastname'] as String,
      json['picture'] as String,
      json['promo'] as int,
      json['location'] as String,
      json['semester'] as int,
      json['gpa'] as List,
      json['nsstat'] as Map<String, dynamic>,
      json['flags'] as Map<String, dynamic>,
      json['missed'] as List,
      json['modules'] as List,
      json['notes'] as List,
      json['credits'] as int,
      0);
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'lastname': instance.lastName,
      'firstname': instance.firstName,
      'picture': instance.pictureUrl,
      'promo': instance.promo,
      'location': instance.location,
      'semester': instance.semester,
      'gpa': instance.gpa,
      'credits': instance.credits,
      'nsstat': instance.nsstat,
      'flags': instance.flags,
      'ghostLen': instance.ghostLen,
      'missed': instance.missed,
      'modules': instance.modules,
      'notes': instance.marks
    };
