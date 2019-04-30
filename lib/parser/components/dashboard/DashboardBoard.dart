import 'package:json_annotation/json_annotation.dart';
import '../subcomponents/Project.dart';
import '../subcomponents/Mark.dart';
import '../subcomponents/Activity.dart';
import '../subcomponents/Module.dart';

part 'DashboardBoard.g.dart';

@JsonSerializable()
class Board {
    @JsonKey(name: "projets")
    List<Project> projects;
    @JsonKey(name: "notes")
    List<Marks> marks;
    @JsonKey(name: "activites")
    List<Activity> activities;
    @JsonKey(name: "modules")
    List<Module> modules;

    /// Board Ctor
    Board(this.projects, this.marks, this.activities, this.modules);

    /// Board fromJson serialization method
    factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

    /// Board toJson serialization method
    Map<String, dynamic> toJson() => _$BoardToJson(this);
}