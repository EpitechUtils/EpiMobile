import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/subcomponents/Activity.dart';

part 'ModuleInformation.g.dart';

@JsonSerializable()
class ModuleInformation {
    @JsonKey(name: "scolaryear")
    final String scolarYear;
    @JsonKey(name: "codemodule")
    final String codeModule;
    @JsonKey(name: "codeinstance")
    final String codeInstance;
    final int semester;
    final String title;
    final String begin;
    final String end;
    @JsonKey(name: "end_register")
    final String endRegister;
    final int credits;
    final String description;
    final List<Activity> activites;

    ModuleInformation(this.scolarYear, this.activites, this.description, this.end, this.title, this.semester,
      this.codeInstance, this.codeModule, this.begin, this.credits, this.endRegister);

    factory ModuleInformation.fromJson(Map<String, dynamic> json) => _$ModuleInformationFromJson(json);

    Map<String, dynamic> toJson() => _$ModuleInformationToJson(this);
}
