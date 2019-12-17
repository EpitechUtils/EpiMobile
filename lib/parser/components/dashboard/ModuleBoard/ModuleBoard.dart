import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/dashboard/ModuleBoard/BoardModule.dart';

part 'ModuleBoard.g.dart';

@JsonSerializable()
class ModuleBoard {
    final List<BoardModule> modules;
    List<BoardModule> registeredProjects = new List<BoardModule>();
    int projectsToDeliveryAmount;

    ModuleBoard(this.modules);

    factory ModuleBoard.fromJson(Map<String, dynamic> json) => _$ModuleBoardFromJson(json);

    Map<String, dynamic> toJson() => _$ModuleBoardToJson(this);
}