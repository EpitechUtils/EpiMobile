import 'package:json_annotation/json_annotation.dart';

part 'Module.g.dart';

@JsonSerializable()
class Module {
    @JsonKey(name: "title")
    final String name;
    @JsonKey(name: "title_link")
    final String titleLink;
    @JsonKey(name: "timeline_start")
    final String timelineStart;
    @JsonKey(name: "timeline_end")
    final String timelineEnd;
    @JsonKey(name: "timeline_barre")
    final String timelineBarre;
    @JsonKey(name: "date_inscription")
    final dynamic inscriptionDate;

    Module(this.name, this.titleLink, this.timelineStart, this.timelineEnd,
        this.timelineBarre, this.inscriptionDate);

    factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

    Map<String, dynamic> toJson() => _$ModuleToJson(this);
}