import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/shared/models/cat_json_data.dart';

@immutable
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

  CatJsonData toCatJsonData() 
    => CatJsonData(id, tags, createdAt, url);
}