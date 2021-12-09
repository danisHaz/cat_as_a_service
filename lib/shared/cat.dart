import 'package:json_annotation/json_annotation.dart';

part 'cat.g.dart';

@JsonSerializable()
class Cat {
	final String id;
	final List<String> tags;
	final String createdAt;
	Cat(
		this.id,
		this.tags,
		this.createdAt
	);
	factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);
	Map<String, dynamic> toJson() => _$CatToJson(this);
}