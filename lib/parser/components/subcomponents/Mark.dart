import 'package:json_annotation/json_annotation.dart';

part 'Mark.g.dart';

@JsonSerializable()
class Marks {
    @JsonKey(name: "title")
    final String name;
    @JsonKey(name: "title_link")
    final String urlLink;
    @JsonKey(name: "note")
    final DateTime mark;
    @JsonKey(name: "noteur")
    final DateTime markAuthor;

    Marks(this.name, this.urlLink, this.mark, this.markAuthor);

    factory Marks.fromJson(Map<String, dynamic> json) => _$MarkFromJson(json);

    Map<String, dynamic> toJson() => _$MarkToJson(this);
}