// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScheduleSession.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleSession _$ScheduleSessionFromJson(Map<String, dynamic> json) {
  return ScheduleSession(
      json['title'] as String,
      json['codemodule'] as String,
      json['scolar_year'] as String,
      json['codeinstance'] as String,
      json['start'] as String,
      json['room'] == null
          ? null
          : ScheduleRoom.fromJson(json['room'] as Map<String, dynamic>),
      json['end'] as String,
      json['semester'] as int,
      json['actititle'] as String,
      json['allow_register'] as bool,
      json['codeacti'] as String,
      json['codeevent'] as String,
      json['event_registered'],
      json['nb_hours'] as String,
      json['module_available'] as bool,
      json['module_registered'] as bool,
      json['titlemodule'] as String,
      json['total_students_registered'] as int,
      (json['prof_inst'] as List)
          ?.map((e) => e == null
              ? null
              : ScheduleProfessor.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ScheduleSessionToJson(ScheduleSession instance) =>
    <String, dynamic>{
      'scolar_year': instance.scolarYear,
      'codemodule': instance.codeModule,
      'codeinstance': instance.codeInstance,
      'codeacti': instance.codeActivity,
      'codeevent': instance.codeEvent,
      'semester': instance.semester,
      'title': instance.title,
      'titlemodule': instance.moduleTitle,
      'actititle': instance.activityTitle,
      'start': instance.start,
      'end': instance.end,
      'total_students_registered': instance.numberStudentsRegistered,
      'nb_hours': instance.hoursAmount,
      'module_available': instance.moduleAvailable,
      'module_registered': instance.moduleRegistered,
      'allow_register': instance.allowRegister,
      'event_registered': instance.eventRegistered,
      'prof_inst': instance.professors,
      'room': instance.room
    };
