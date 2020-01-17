import 'package:json_annotation/json_annotation.dart';

part 'ScheduleProfessor.g.dart';

@JsonSerializable()
class ScheduleProfessor {
    final String type;
    final String login;
    final String title;

    ScheduleProfessor(this.type, this.title, this.login);

    factory ScheduleProfessor.fromJson(Map<String, dynamic> json) => _$ScheduleProfessorFromJson(json);

    Map<String, dynamic> toJson() => _$ScheduleProfessorToJson(this);
}