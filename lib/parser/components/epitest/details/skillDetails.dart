import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/epitest/details/fullSkillReport.dart';
import 'package:mobile_intranet/parser/components/epitest/details/skillContainer.dart';

part 'skillDetails.g.dart';

@JsonSerializable()
class SkillDetails {
    List<SkillContainer> skills;

    SkillDetails(this.skills);

    factory SkillDetails.fromJson(Map<String, dynamic> json) => _$SkillDetailsFromJson(json);

    Map<String, dynamic> toJson() => _$SkillDetailsToJson(this);
}