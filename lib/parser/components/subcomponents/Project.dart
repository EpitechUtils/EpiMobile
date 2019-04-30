import 'package:json_annotation/json_annotation.dart';

part 'Project.g.dart';

@JsonSerializable()
class Project {
    @JsonKey(name: "title")
    final String name;
    @JsonKey(name: "title_link")
    final String urlLink;
    @JsonKey(name: "timeline_start")
    final DateTime startDate;
    @JsonKey(name: "timeline_end")
    final DateTime endDate;
    @JsonKey(name: "timeline_barre")
    final double timeline;
    @JsonKey(name: "date_inscription")
    final DateTime inscriptionDate;

    Project(this.endDate, this.inscriptionDate, this.name,
        this.startDate, this.timeline, this.urlLink);

    factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

    Map<String, dynamic> toJson() => _$ProjectToJson(this);
}