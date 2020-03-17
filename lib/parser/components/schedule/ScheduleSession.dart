import 'package:json_annotation/json_annotation.dart';
import 'ScheduleProfessor.dart';
import 'ScheduleRoom.dart';

part 'ScheduleSession.g.dart';

@JsonSerializable()
class ScheduleSession {
    @JsonKey(name: "scolaryear")
    final String scolarYear;
    @JsonKey(name: "codemodule")
    final String codeModule; // G-EPI-004
    @JsonKey(name: "codeinstance")
    final String codeInstance; // NCE-0-1
    @JsonKey(name: "codeacti")
    final String codeActivity; // acti-347242
    @JsonKey(name: "codeevent")
    final String codeEvent; // event-352146
    final int semester;
    final String title;
    @JsonKey(name: "titlemodule")
    final String moduleTitle;
    @JsonKey(name: "acti_title")
    final String activityTitle;
    final String start;
    final String end;
    @JsonKey(name: "total_students_registered")
    final int numberStudentsRegistered;
    @JsonKey(name: "nb_hours")
    final String hoursAmount;
    @JsonKey(name: "module_available")
    final bool moduleAvailable; // user can register to this module
    @JsonKey(name: "module_registered")
    final bool moduleRegistered; // user is registered to this module
    @JsonKey(name: "allow_register")
    final bool allowRegister; // user can register to this activity
    @JsonKey(name: "event_registered")
    dynamic eventRegistered; // state of registration (false if not registered, String if registered depending on the state)
    @JsonKey(name: "prof_inst")
    final List<ScheduleProfessor> professors;
    final ScheduleRoom room;
    @JsonKey(name: "is_rdv")
    final String hasRdv;
    @JsonKey(name: "type_title")
    final String typeTitle;
    @JsonKey(name: "type_code")
    final String typeCode;

    ScheduleSession(this.title, this.codeModule, this.scolarYear, this.codeInstance, this.start,
	    this.room, this.end, this.semester, this.activityTitle, this.allowRegister, this.codeActivity,
	    this.codeEvent, this.eventRegistered, this.hoursAmount, this.moduleAvailable, this.moduleRegistered,
        this.moduleTitle, this.numberStudentsRegistered, this.professors, this.hasRdv, this.typeCode, this.typeTitle);

    factory ScheduleSession.fromJson(Map<String, dynamic> json) => _$ScheduleSessionFromJson(json);

    Map<String, dynamic> toJson() => _$ScheduleSessionToJson(this);
}