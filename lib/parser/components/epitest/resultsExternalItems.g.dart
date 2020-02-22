// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultsExternalItems.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultsExternalItems _$ResultsExternalItemsFromJson(Map<String, dynamic> json) {
  return ResultsExternalItems((json['value'] as num)?.toDouble(),
      json['type'] as String, json['comment'] as String);
}

Map<String, dynamic> _$ResultsExternalItemsToJson(
        ResultsExternalItems instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
      'comment': instance.comment
    };
