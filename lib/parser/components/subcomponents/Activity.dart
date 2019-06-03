import 'package:json_annotation/json_annotation.dart';

part 'Activity.g.dart';

@JsonSerializable()
class Activity {
    @JsonKey(name: "title")
    final String name;
    @JsonKey(name: "module")
    final String module;
    @JsonKey(name: "module_link")
    final String moduleLink;
    @JsonKey(name: "module_code")
    final String moduleCode;
    @JsonKey(name: "title_link")
    final String titleLink;
    @JsonKey(name: "timeline_start")
    final String timelineStart;
    @JsonKey(name: "timeline_end")
    final String timelineEnd;
    @JsonKey(name: "timeline_barre")
    final String timelineBarre;
    @JsonKey(name: "salle")
    final String room;
    @JsonKey(name: "intervenant")
    final String teacher;
    @JsonKey(name: "date_inscription")
    final dynamic inscriptionDate;
    @JsonKey(name: "register_link")
    final String registerLink;

    Activity(this.name, this.module, this.moduleLink, this.moduleCode,
        this.titleLink, this.timelineStart, this.timelineEnd, this.timelineBarre,
        this.room, this.teacher, this.inscriptionDate, this.registerLink);

    factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);

    Map<String, dynamic> toJson() => _$ActivityToJson(this);
}