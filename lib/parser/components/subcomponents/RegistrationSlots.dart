import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/subcomponents/RegistrationSlotsBlocks.dart';

part 'RegistrationSlots.g.dart';

@JsonSerializable()
class RegistrationSlots
{
    List<RegistrationSlotsBlocks> slots;

    RegistrationSlots(this.slots);

    factory RegistrationSlots.fromJson(Map<String, dynamic> json) => _$RegistrationSlotsFromJson(json);

    Map<String, dynamic> toJson() => _$RegistrationSlotsToJson(this);
}