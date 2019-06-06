import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/subcomponents/moduleProject/ModuleProjectGroup.dart';

part 'ModuleProject.g.dart';

@JsonSerializable()
class ModuleProject {
    @JsonKey(name: "module_title")
    final String moduleName;
    @JsonKey(name: "project_title")
    final String projectTitle;
    @JsonKey(name: "codeinstance")
    final String codeInstance;
    @JsonKey(name: "nb_min")
    final int groupMin;
    @JsonKey(name: "nb_max")
    final int groupMax;
    @JsonKey(name: "closed")
    final bool inscriptionClosed;
    @JsonKey(name: "user_project_status")
    final String userProjectStatus;
    @JsonKey(name: "user_project_title")
    final String userProjectName;
    @JsonKey(name: "registered")
    final List<ModuleProjectGroup> groups;
    @JsonKey(name: "end")
    final String end;

    ModuleProject(this.moduleName, this.projectTitle, this.groupMax, this.groupMin,
        this.groups, this.inscriptionClosed, this.userProjectName, this.userProjectStatus, this.end, this.codeInstance);

    factory ModuleProject.fromJson(Map<String, dynamic> json) => _$ModuleProjectFromJson(json);

    Map<String, dynamic> toJson() => _$ModuleProjectToJson(this);
}