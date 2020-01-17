import 'package:json_annotation/json_annotation.dart';

part 'ProfileMark.g.dart';

@JsonSerializable()
class ProfileMark {
    @JsonKey(name: "title")
    final String name;
    @JsonKey(name: "date")
    final String date;
    @JsonKey(name: "final_note")
    final double mark;
    @JsonKey(name: "scolaryear")
    final int scolarYear;
    @JsonKey(name: "codemodule")
    final String codeModule;

    ProfileMark(this.name, this.date, this.mark, this.scolarYear, this.codeModule);

    factory ProfileMark.fromJson(Map<String, dynamic> json) => _$ProfileMarkFromJson(json);

    Map<String, dynamic> toJson() => _$ProfileMarkToJson(this);
}