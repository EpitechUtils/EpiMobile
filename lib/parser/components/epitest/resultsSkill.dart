import 'package:json_annotation/json_annotation.dart';

part 'resultsSkill.g.dart';

@JsonSerializable()
class ResultsSkill
{
    int count;
    int passed;
    int crashed;
    int mandatoryFailed;

    ResultsSkill(this.count, this.crashed, this.mandatoryFailed, this.passed);

    factory ResultsSkill.fromJson(Map<String, dynamic> json) => _$ResultsSkillFromJson(json);

    Map<String, dynamic> toJson() => _$ResultsSkillToJson(this);
}