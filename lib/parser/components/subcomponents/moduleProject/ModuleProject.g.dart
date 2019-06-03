// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ModuleProject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleProject _$ModuleProjectFromJson(Map<String, dynamic> json) {
  return ModuleProject(
      json['module_title'] as String,
      json['project_title'] as String,
      json['nb_max'] as int,
      json['nb_min'] as int,
      (json['registered'] as List)
          ?.map((e) => e == null
              ? null
              : ModuleProjectGroup.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['closed'] as bool,
      json['user_project_title'] as String,
      json['user_project_status'] as String,
      json['end'] as String);
}

Map<String, dynamic> _$ModuleProjectToJson(ModuleProject instance) =>
    <String, dynamic>{
      'module_title': instance.moduleName,
      'project_title': instance.projectTitle,
      'nb_min': instance.groupMin,
      'nb_max': instance.groupMax,
      'closed': instance.inscriptionClosed,
      'user_project_status': instance.userProjectStatus,
      'user_project_title': instance.userProjectName,
      'registered': instance.groups,
      'end': instance.end
    };
