import 'package:json_annotation/json_annotation.dart';

part 'RegistrationSlotMember.g.dart';

@JsonSerializable()
class RegistrationSlotMember
{
    String login;
    String title;
    String picture;

    RegistrationSlotMember(this.title, this.login, this.picture);

    factory RegistrationSlotMember.fromJson(Map<String, dynamic> json) => _$RegistrationSlotMemberFromJson(json);

    Map<String, dynamic> toJson() => _$RegistrationSlotMemberToJson(this);
}