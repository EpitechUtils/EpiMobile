import 'package:json_annotation/json_annotation.dart';

part 'RegistrationSlotGroup.g.dart';

@JsonSerializable()
class RegistrationSlotGroup
{
    int id;
    String title;
    String master;
    List<String> members;

    RegistrationSlotGroup(this.title, this.id, this.members, this.master);

    factory RegistrationSlotGroup.fromJson(Map<String, dynamic> json) => _$RegistrationSlotGroupFromJson(json);

    Map<String, dynamic> toJson() => _$RegistrationSlotGroupToJson(this);
}