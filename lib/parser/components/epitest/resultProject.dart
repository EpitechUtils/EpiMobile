import 'package:json_annotation/json_annotation.dart';

part 'resultProject.g.dart';

@JsonSerializable()
class ResultProject
{
    String slug;
    String name;

    ResultProject(this.slug, this.name);

    factory ResultProject.fromJson(Map<String, dynamic> json) => _$ResultProjectFromJson(json);

    Map<String, dynamic> toJson() => _$ResultProjectToJson(this);
}