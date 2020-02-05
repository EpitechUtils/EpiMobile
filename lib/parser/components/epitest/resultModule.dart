import 'package:json_annotation/json_annotation.dart';

part 'resultModule.g.dart';

@JsonSerializable()
class ResultModule
{
    String code;

    ResultModule(this.code);

    factory ResultModule.fromJson(Map<String, dynamic> json) => _$ResultModuleFromJson(json);

    Map<String, dynamic> toJson() => _$ResultModuleToJson(this);
}