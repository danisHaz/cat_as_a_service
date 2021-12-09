import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cat.g.dart';
@immutable
@JsonSerializable(explicitToJson: true)
class Cat {
	final String id;
	final List<String> tags;
	final String createdAt;
  final String url;
	const Cat({
	  required this.id,
		required this.tags,
		required this.createdAt,
    required this.url
  });

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);
	Map<String, dynamic> toJson() => _$CatToJson(this);
}