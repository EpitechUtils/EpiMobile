import 'package:json_annotation/json_annotation.dart';
import 'ScheduleSession.dart';

part 'ScheduleDay.g.dart';

@JsonSerializable()
class ScheduleDay {
    List<ScheduleSession> sessions;

    ScheduleDay(this.sessions);

    factory ScheduleDay.fromJson(Map<String, dynamic> json) => _$ScheduleDayFromJson(json);

    Map<String, dynamic> toJson() => _$ScheduleDayToJson(this);
}