import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cat.g.dart';

enum CatDecorationFilter{
  none,
  sepia,
  blur,
  mono,
  negative,
  paint,
}

extension CatDecrationFilterExtensions on CatDecorationFilter? {
  String emptyIfNull() {
    return this?.toString().split(".").last ?? "";
  }

  List<T> customMap<T>(T Function(CatDecorationFilter filter) func) =>
    List.of([
      func(CatDecorationFilter.none),
      func(CatDecorationFilter.sepia),
      func(CatDecorationFilter.blur),
      func(CatDecorationFilter.mono),
      func(CatDecorationFilter.negative),
      func(CatDecorationFilter.paint),
    ]);
    
  bool equals(Object other) {
    return other is CatDecorationFilter && other.toString() == toString();
  }
}

extension StringExtensions on String? {
  String emptyIfNull() => this ?? "";
}

@immutable
@JsonSerializable(explicitToJson: true)
class Cat {
	final String id;
	final List<String> tags;
  final String? textColor;
  final double? fontSize;
  final String? text;
  final CatDecorationFilter? filter;
  final String? type;
  final double? height;
  final double? width;
  String get url => "$BASE_URL/cat/$id"
        + (text.emptyIfNull().isEmpty == true ? "" : "/says/$text")
        + "?filter=${filter.emptyIfNull()}"
        + "&color=${textColor.emptyIfNull()}&type=${type.emptyIfNull()}"
        + "&size=${fontSize ?? ""}&height=${height ?? ""}&width=${width ?? ""}";

	const Cat({
	  required this.id,
    required this.tags,
    this.textColor,
    this.fontSize,
    this.text,
    this.filter,
    this.type,
    this.height,
    this.width
  });

	factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);

	Map<String, dynamic> toJson() => _$CatToJson(this);

	Cat copyWith({
    String? id,
    List<String>? tags,
    String? textColor,
    double? fontSize,
    String? text,
    CatDecorationFilter? filter,
    String? type,
    double? height,
    double? width,
  }) {
    return Cat(
      id: id ?? this.id,
      tags: tags ?? this.tags,
      textColor: textColor ?? this.textColor,
      fontSize: fontSize ?? this.fontSize,
      text: text ?? this.text,
      filter: filter ?? this.filter,
      type: type ?? this.type,
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }

}