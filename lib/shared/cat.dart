import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/shared/cat_decoration.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';

part 'cat.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Cat {
	final String id;
	final List<String> tags;

	@JsonKey(readValue: _readDecoration)
	final CatDecoration decoration;


	Cat({
	  required this.id,
    required this.tags,
		this.decoration = const CatDecoration(text: '', filter: CatDecorationFilter.none),
  });


	static Map<String, dynamic> _readDecoration(Map map, String key){
		final _map = map as Map<String, dynamic>;
		if(_map.containsKey(key)){
			return _map[key];
		} else {
			return {};
		}
	}

	String get url{
		final says = decoration.text.isNotEmpty ? '/says/${decoration.text}' : '';
		var filter = '?filter=';
		switch(decoration.filter){
			case CatDecorationFilter.none:
				filter = '';
				break;
			case CatDecorationFilter.sepia:
				filter += 'sepia';
				break;
			case CatDecorationFilter.blur:
				filter += 'blur';
				break;
			case CatDecorationFilter.mono:
				filter += 'mono';
				break;
			case CatDecorationFilter.negative:
				filter += 'negative';
				break;
			case CatDecorationFilter.paint:
				filter += 'paint';
				break;
		}


		return '/cat/$id$says$filter';
	}

	@override
  bool operator ==(Object other){
		return other is Cat && other.url == url;
	}

	factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);

	Map<String, dynamic> toJson() => _$CatToJson(this);

	Cat copyWith({
    String? id,
    List<String>? tags,
    CatDecoration? decoration,
  }) {
    return Cat(
      id: id ?? this.id,
      tags: tags ?? this.tags,
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  int get hashCode => url.hashCode;

}