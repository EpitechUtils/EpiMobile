import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/epitest/resultModule.dart';

part 'resultProject.g.dart';

@JsonSerializable()
class ResultProject
{
    String slug;
    String name;
    ResultModule module;

    ResultProject(this.slug, this.name, this.module);

    factory ResultProject.fromJson(Map<String, dynamic> json) => _$ResultProjectFromJson(json);

    Map<String, dynamic> toJson() => _$ResultProjectToJson(this);
}