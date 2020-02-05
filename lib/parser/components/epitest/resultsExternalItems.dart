import 'package:json_annotation/json_annotation.dart';

part 'resultsExternalItems.g.dart';

@JsonSerializable()
class ResultsExternalItems
{
    String type;
    int value;
    String comment;

    ResultsExternalItems(this.value, this.type, this.comment);

    factory ResultsExternalItems.fromJson(Map<String, dynamic> json) => _$ResultsExternalItemsFromJson(json);

    Map<String, dynamic> toJson() => _$ResultsExternalItemsToJson(this);
}