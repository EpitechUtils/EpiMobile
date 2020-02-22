// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Results _$ResultsFromJson(Map<String, dynamic> json) {
  return Results((json['results'] as List)
      ?.map(
          (e) => e == null ? null : Result.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$ResultsToJson(Results instance) =>
    <String, dynamic>{'results': instance.results};
