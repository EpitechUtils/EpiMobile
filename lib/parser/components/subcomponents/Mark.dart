import 'package:json_annotation/json_annotation.dart';

part 'Mark.g.dart';

@JsonSerializable()
class Mark {
    @JsonKey(name: "title")
    final String name;
    @JsonKey(name: "title_link")
    final String urlLink;
    @JsonKey(name: "note")
    final DateTime mark;
    @JsonKey(name: "noteur")
    final DateTime markAuthor;

    Mark(this.name, this.urlLink, this.mark, this.markAuthor);

    factory Mark.fromJson(Map<String, dynamic> json) => _$MarkFromJson(json);

    Map<String, dynamic> toJson() => _$MarkToJson(this);
}