import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/shared/cat_decoration.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cat.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Cat {
	final String id;
	final List<String> tags;

	@JsonKey(readValue: _readUrl)
  final String url;
	const Cat({
	  required this.id,
		required this.tags,
    required this.url
  });

	static String _readUrl(Map map, String key){
		final _map = map as Map<String, dynamic>;
		if(_map.containsKey(key)){
			return _map[key];
		}else{
			return '/cat/${_map['id']}';
		}
	}


  Cat decorated(CatDecoration decoration){
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


  	final newUrl = '/cat/$id$says$filter';
  	return Cat(
			id: id,
			tags: tags,
			url: newUrl,
		);
	}

	factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);

	Map<String, dynamic> toJson() => _$CatToJson(this);
}