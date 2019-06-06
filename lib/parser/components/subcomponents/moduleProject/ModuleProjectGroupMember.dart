import 'package:json_annotation/json_annotation.dart';

part 'ModuleProjectGroupMember.g.dart';

@JsonSerializable()
class ModuleProjectGroupMember {
    @JsonKey(name: "title")
    final String name;
    final String picture;
    final String status;
    final String login;

    ModuleProjectGroupMember(this.name, this.picture, this.status, this.login);

    factory ModuleProjectGroupMember.fromJson(Map<String, dynamic> json) => _$ModuleProjectGroupMemberFromJson(json);

    Map<String, dynamic> toJson() => _$ModuleProjectGroupMemberToJson(this);
}