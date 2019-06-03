import 'package:json_annotation/json_annotation.dart';
import '../subcomponents/Project.dart';
import '../subcomponents/Mark.dart';
import '../subcomponents/Activity.dart';
import '../subcomponents/Module.dart';

part 'Dashboard.g.dart';

@JsonSerializable()
class Dashboard {
    @JsonKey(name: "projets")
    List<Project> projects;
    @JsonKey(name: "notes")
    List<Mark> marks;
    @JsonKey(name: "activites")
    List<Activity> activities;
    @JsonKey(name: "modules")
    List<Module> modules;

    /// Board Ctor
    Dashboard(this.projects, this.marks, this.activities, this.modules);

    /// Board fromJson serialization method
    factory Dashboard.fromJson(Map<String, dynamic> json) => _$DashboardFromJson(json);

    /// Board toJson serialization method
    Map<String, dynamic> toJson() => _$DashboardToJson(this);
}