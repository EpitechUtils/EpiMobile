import 'package:json_annotation/json_annotation.dart';

part 'ProfileModules.g.dart';

@JsonSerializable()
class ProfileModules {
    @JsonKey(name: "scolaryear")
    int scolarYear;
    String title;
    int credits;
    String grade;
    @JsonKey(name: "codemodule")
    String codeModule;
    @JsonKey(name: "codeinstance")
    String codeInstance;

    ProfileModules(this.codeInstance, this.codeModule, this.title, this.scolarYear, this.credits, this.grade);

    factory ProfileModules.fromJson(Map<String, dynamic> json) => _$ProfileModulesFromJson(json);

    Map<String, dynamic> toJson() => _$ProfileModulesToJson(this);

}