import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_intranet/parser/components/epitest/result.dart';

part 'results.g.dart';

@JsonSerializable()
class Results {
	List<Result> results;

	Results(this.results);

	factory Results.fromJson(Map<String, dynamic> json) => _$ResultsFromJson(json);

	Map<String, dynamic> toJson() => _$ResultsToJson(this);
}