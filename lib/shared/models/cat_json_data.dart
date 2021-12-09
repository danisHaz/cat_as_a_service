import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../cat.dart';

class CatJsonData {
	final String id;
	final List<String> tags;
	final String createdAt;
  final String url;
	CatJsonData(
		this.id,
		this.tags,
		this.createdAt,
    this.url
	);

	Cat convertToCat() => Cat(id: id, tags: tags, createdAt: createdAt, url: url);

  CatJsonData copyWith({
    String? id,
    List<String>? tags,
    String? createdAt,
    String? url,
  }) {
    return CatJsonData(
      id ?? this.id,
      tags ?? this.tags,
      createdAt ?? this.createdAt,
      url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tags': tags,
      'created_at': createdAt,
      'url': url,
    };
  }

  factory CatJsonData.fromMap(Map<String, dynamic> map) {
    return CatJsonData(
      map['id'],
      List<String>.from(map['tags']),
      map['created_at'],
      map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CatJsonData.fromJson(String source) => CatJsonData.fromMap(json.decode(source));

  @override
  String toString() => 'CatJsonData(id: $id, tags: $tags, created_at: $createdAt, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CatJsonData &&
      other.id == id &&
      listEquals(other.tags, tags) &&
      other.createdAt == createdAt && other.url == url;
  }

  @override
  int get hashCode => id.hashCode ^ tags.hashCode ^ createdAt.hashCode ^ url.hashCode;
}