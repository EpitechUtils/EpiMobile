import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/subcomponents/moduleProject/ModuleProjectGroupMember.dart';

part 'ModuleProjectGroup.g.dart';

@JsonSerializable()
class ModuleProjectGroup {
    @JsonKey(name: "title")
    final String groupName;
    final bool closed;
    final ModuleProjectGroupMember master;
    final List<ModuleProjectGroupMember> members;

    ModuleProjectGroup(this.groupName, this.closed, this.master, this.members);

    factory ModuleProjectGroup.fromJson(Map<String, dynamic> json) => _$ModuleProjectGroupFromJson(json);

    Map<String, dynamic> toJson() => _$ModuleProjectGroupToJson(this);
}