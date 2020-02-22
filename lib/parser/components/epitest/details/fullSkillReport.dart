import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/epitest/details/fullSkillReportTests.dart';

part 'fullSkillReport.g.dart';

@JsonSerializable()
class FullSkillReport {
    String name;
    List<FullSkillReportTests> tests;
    double percent;

    FullSkillReport(this.name, this.tests);

    factory FullSkillReport.fromJson(Map<String, dynamic> json) => _$FullSkillReportFromJson(json);

    Map<String, dynamic> toJson() => _$FullSkillReportToJson(this);

}