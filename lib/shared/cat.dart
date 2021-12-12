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
  final String created_at;

	@JsonKey(readValue: _readUrl)
  String? url;
	Cat({
	  required this.id,
		required this.created_at,
    required this.tags,
    required String? url
  }) {
    String nonNullableUrl = (url ?? "/cat/$id");
    this.url = nonNullableUrl == 'null' ? "/cat/$id" : nonNullableUrl;
  }

	static String _readUrl(Map map, String key){
		final _map = map as Map<String, dynamic>;
		if(_map.containsKey(key)){
			return _map[key];
		} else {
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
      created_at: created_at,
			tags: tags,
			url: newUrl,
		);
	}

	factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);

	Map<String, dynamic> toJson() => _$CatToJson(this);

}