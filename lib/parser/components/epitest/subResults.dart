import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/epitest/resultsSkill.dart';
import 'package:mobile_intranet/parser/components/epitest/resultsExternalItems.dart';

part 'subResults.g.dart';

@JsonSerializable()
class SubResults
{
    List<String> logins;
    double prerequisites;
    Map<String, ResultsSkill> skills;
    double percentage;
    String mark;
    double mandatoryFailed;
    List<ResultsExternalItems> externalItems;

    SubResults(this.logins, this.mandatoryFailed, this.mark, this.externalItems, this.prerequisites, this.skills);

    factory SubResults.fromJson(Map<String, dynamic> json) => _$SubResultsFromJson(json);

    Map<String, dynamic> toJson() => _$SubResultsToJson(this);
}