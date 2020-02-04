import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/subcomponents/registrationSlot/RegistrationSlotMember.dart';

part 'RegistrationSlot.g.dart';

@JsonSerializable()
class RegistrationSlot
{
    String date;
    int duration;
    String status;
    @JsonKey(name: "bloc_status")
    String blockStatus;
    @JsonKey(name: "id")
    int idSlot;
    String title;
    @JsonKey(name: "members_pictures")
    String membersPictures;
    RegistrationSlotMember master;
    List<RegistrationSlotMember> members;

    RegistrationSlot(this.title, this.duration, this.date, this.status, this.master, this.members,
	this.blockStatus, this.idSlot, this.membersPictures);

    factory RegistrationSlot.fromJson(Map<String, dynamic> json) => _$RegistrationSlotFromJson(json);

    Map<String, dynamic> toJson() => _$RegistrationSlotToJson(this);
}