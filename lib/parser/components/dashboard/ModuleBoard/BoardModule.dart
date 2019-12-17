import 'package:json_annotation/json_annotation.dart';

part 'BoardModule.g.dart';


@JsonSerializable()
class BoardModule {
    @JsonKey(name: "title_module")
    final String moduleName;
    @JsonKey(name: "codemodule")
    final String codeModule;
    @JsonKey(name: "codeinstance")
    final String codeInstance;
    @JsonKey(name: "begin_event")
    final dynamic beginEvent;
    @JsonKey(name: "end_event")
    final dynamic endEvent;
    @JsonKey(name: "type_acti_code")
    final String type;
    @JsonKey(name: "begin_acti")
    final String beginActivity;
    @JsonKey(name: "end_acti")
    final String endActivity;
    final int registered;
    @JsonKey(name: "project")
    final String name;

    BoardModule(this.codeInstance, this.name, this.moduleName, this.beginActivity, this.beginEvent, this.codeModule ,
        this.endActivity, this.endEvent, this.registered, this.type);

    factory BoardModule.fromJson(Map<String, dynamic> json) => _$BoardModuleFromJson(json);

    Map<String, dynamic> toJson() => _$BoardModuleToJson(this);
}