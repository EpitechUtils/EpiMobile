import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/subcomponents/RegistrationSlotMember.dart';

part 'RegistrationSlot.g.dart';

@JsonSerializable()
class RegistrationSlot
{
    String date;
    int duration;
    String status;
    @JsonKey(name: "bloc_status")
    String blockStatus;
    @JsonKey(name: "id_team")
    String idTeam;
    String title;
    @JsonKey(name: "members_pictures")
    String membersPictures;
    RegistrationSlotMember master;
    List<RegistrationSlotMember> members;

    RegistrationSlot(this.title, this.duration, this.date, this.status, this.master, this.members,
	this.blockStatus, this.idTeam, this.membersPictures);

    factory RegistrationSlot.fromJson(Map<String, dynamic> json) => _$RegistrationSlotFromJson(json);

    Map<String, dynamic> toJson() => _$RegistrationSlotToJson(this);
}