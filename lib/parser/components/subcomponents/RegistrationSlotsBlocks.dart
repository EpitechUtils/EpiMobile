import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/subcomponents/RegistrationSlot.dart';

part 'RegistrationSlotsBlocks.g.dart';

@JsonSerializable()
class RegistrationSlotsBlocks
{
    @JsonKey(name: "slots")
    List<RegistrationSlot> blocks;
    @JsonKey(name: "block_status")
    String blockStatus;
    String room;

    RegistrationSlotsBlocks(this.blocks, this.room, this.blockStatus);

    factory RegistrationSlotsBlocks.fromJson(Map<String, dynamic> json) => _$RegistrationSlotsBlocksFromJson(json);

    Map<String, dynamic> toJson() => _$RegistrationSlotsBlocksToJson(this);
}