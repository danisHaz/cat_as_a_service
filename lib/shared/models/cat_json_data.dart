import 'package:json_annotation/json_annotation.dart';

import '../cat.dart';

part 'cat_json_data.g.dart';

@JsonSerializable(explicitToJson: true)
class CatJsonData {
	final String id;
	final List<String> tags;
  final String created_at;
	String get createdAt => created_at;
  
  final String url;
	CatJsonData(
		this.id,
		this.tags,
		this.created_at,
    this.url
	);

  Cat toCat() => Cat(id: id, tags: tags, createdAt: createdAt, url: url);

  factory CatJsonData.fromJson(Map<String, dynamic> json) => _$CatJsonDataFromJson(json);

  Map<String, dynamic> toJson() => _$CatJsonDataToJson(this);
}