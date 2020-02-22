import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/epitest/details/fullSkillReport.dart';

part 'skillContainer.g.dart';

@JsonSerializable()
class SkillContainer {
    @JsonKey(name: "FullSkillReport")
    FullSkillReport fullSkillReport;

    SkillContainer(this.fullSkillReport);

    factory SkillContainer.fromJson(Map<String, dynamic> json) => _$SkillContainerFromJson(json);

    Map<String, dynamic> toJson() => _$SkillContainerToJson(this);
}