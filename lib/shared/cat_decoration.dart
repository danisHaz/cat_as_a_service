import 'package:json_annotation/json_annotation.dart';


part 'cat_decoration.g.dart';

@JsonSerializable(explicitToJson: true)
class CatDecoration{
  @JsonKey(defaultValue: '')
  final String text;
  @JsonKey(defaultValue: CatDecorationFilter.none)
  final CatDecorationFilter filter;

  const CatDecoration({
    required this.text,
    required this.filter,
  });

  factory CatDecoration.fromJson(Map<String, dynamic> json) => _$CatDecorationFromJson(json);

  Map<String, dynamic> toJson() => _$CatDecorationToJson(this);

}

enum CatDecorationFilter{
  none,
  sepia,
  blur,
  mono,
  negative,
  paint,
}

