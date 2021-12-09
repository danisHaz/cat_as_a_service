import 'package:flutter/widgets.dart';

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
}