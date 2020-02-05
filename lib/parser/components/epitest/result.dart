import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/epitest/resultModule.dart';
import 'package:mobile_intranet/parser/components/epitest/resultProject.dart';
import 'package:mobile_intranet/parser/components/epitest/subResults.dart';

part 'result.g.dart';

@JsonSerializable()
class Result
{
    ResultProject project;
    ResultModule module;
    SubResults results;
    String date;

    Result(this.project, this.date, this.module, this.results);

    factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

    Map<String, dynamic> toJson() => _$ResultToJson(this);
}