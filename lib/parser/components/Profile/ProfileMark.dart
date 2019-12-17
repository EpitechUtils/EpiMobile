import 'package:json_annotation/json_annotation.dart';

part 'ProfileMark.g.dart';

@JsonSerializable()
class ProfileMark {
    @JsonKey(name: "title")
    final String name;
    @JsonKey(name: "title_link")
    final String urlLink;
    @JsonKey(name: "note")
    final String mark;
    @JsonKey(name: "noteur")
    final String markAuthor;

    ProfileMark(this.name, this.urlLink, this.mark, this.markAuthor);

    factory ProfileMark.fromJson(Map<String, dynamic> json) => _$ProfileMarkFromJson(json);

    Map<String, dynamic> toJson() => _$ProfileMarkToJson(this);
}