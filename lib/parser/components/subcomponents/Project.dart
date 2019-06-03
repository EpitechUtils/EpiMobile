import 'package:json_annotation/json_annotation.dart';

part 'Project.g.dart';

@JsonSerializable()
class Project {
    @JsonKey(name: "title")
    final String name;
    @JsonKey(name: "title_link")
    final String urlLink;
    @JsonKey(name: "timeline_start")
    final String startDate;
    @JsonKey(name: "timeline_end")
    final String endDate;
    @JsonKey(name: "timeline_barre")
    final String timeline;
    @JsonKey(name: "date_inscription")
    final dynamic inscriptionDate;
    @JsonKey(name: "id_activite")
    final String id;

    Project(this.endDate, this.inscriptionDate, this.name,
        this.startDate, this.timeline, this.urlLink, this.id);

    factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

    Map<String, dynamic> toJson() => _$ProjectToJson(this);
}