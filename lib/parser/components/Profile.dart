import 'package:json_annotation/json_annotation.dart';

part 'Profile.g.dart';

/// Profile Json serializable class
@JsonSerializable()
class Profile {
    @JsonKey(name: "lastname", nullable: false)
    final String lastName;
    @JsonKey(name: "firstname", nullable: false)
    final String firstName;
    @JsonKey(name: "picture")
    final String pictureUrl;
    final int promo;
    final String location;
    final int semester;
    final List<dynamic> gpa;
    final Map<String, dynamic> nsstat;
    final Map<String, dynamic> flags;
    final List<dynamic> missed;
    final List<dynamic> modules;
    @JsonKey(name: "notes")
    final List<dynamic> marks;

    /// Profile Ctor
    Profile(this.firstName, this.lastName, this.pictureUrl, this.promo,
        this.location, this.semester, this.gpa, this.nsstat, this.flags,
        this.missed, this.modules, this.marks);

    /// Profile fromJson serialization method
    factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

    /// Profile toJson serialization method
    Map<String, dynamic> toJson() => _$ProfileToJson(this);
}