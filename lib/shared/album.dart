import 'package:flutter_basics_2/shared/models/cat_json_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable(explicitToJson: true)
class Album{
  final String id;
  final String name;
  final List<CatJsonData> cats;
  Album(
    this.id,
    this.name,
    this.cats,
  );

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
