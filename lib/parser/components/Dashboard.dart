import 'package:json_annotation/json_annotation.dart';

part 'Dashboard.g.dart';

@JsonSerializable()
class Dashboard {
    @JsonKey(name: "projets")
    final List<dynamic> projects;
    @JsonKey(name: "notes")
    List<dynamic> marks;
    @JsonKey(name: "activites")
    List<dynamic> activities;
    List<dynamic> modules;

    Dashboard(this.projects, this.marks, this.modules, this.activities);

    factory Dashboard.fromJson(Map<String, dynamic> json) {
        Dashboard instance = _$DashboardFromJson(json);

        // Data analyse

        return instance;
    }

        Map<String, dynamic> toJson() => _$DashboardToJson(this);
}