import 'package:json_annotation/json_annotation.dart';

part 'fullSkillReportTests.g.dart';

@JsonSerializable()
class FullSkillReportTests {
    String name;
    bool passed;
    bool crashed;
    bool mandatory;
    String comment;

    FullSkillReportTests(this.name, this.passed, this.comment, this.crashed, this.mandatory);

    factory FullSkillReportTests.fromJson(Map<String, dynamic> json) => _$FullSkillReportTestsFromJson(json);

    Map<String, dynamic> toJson() => _$FullSkillReportTestsToJson(this);
}