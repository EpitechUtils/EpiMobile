import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/subcomponents/registrationSlot/RegistrationSlotsBlocks.dart';
import 'package:mobile_intranet/parser/components/subcomponents/registrationSlot/RegistrationSlotGroup.dart';

part 'RegistrationSlots.g.dart';

@JsonSerializable()
class RegistrationSlots
{
    List<RegistrationSlotsBlocks> slots;
    RegistrationSlotGroup group;

    RegistrationSlots(this.slots, this.group);

    factory RegistrationSlots.fromJson(Map<String, dynamic> json) => _$RegistrationSlotsFromJson(json);

    Map<String, dynamic> toJson() => _$RegistrationSlotsToJson(this);
}