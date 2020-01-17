import 'package:json_annotation/json_annotation.dart';

part 'ScheduleRoom.g.dart';

@JsonSerializable()
class ScheduleRoom {
    final String code;
    final String type;
    final int seats;

    ScheduleRoom(this.type, this.code, this.seats);

    factory ScheduleRoom.fromJson(Map<String, dynamic> json) => _$ScheduleRoomFromJson(json);

    Map<String, dynamic> toJson() => _$ScheduleRoomToJson(this);
}