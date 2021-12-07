import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../cat.dart';

class CatJsonData {
	final int id;
	final List<String> tags;
	final String created_at;
	CatJsonData(
		this.id,
		this.tags,
		this.created_at
	);

	Cat convertToCat() => Cat(id, tags, created_at);

  CatJsonData copyWith({
    int? id,
    List<String>? tags,
    String? created_at,
  }) {
    return CatJsonData(
      id ?? this.id,
      tags ?? this.tags,
      created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tags': tags,
      'created_at': created_at,
    };
  }

  factory CatJsonData.fromMap(Map<String, dynamic> map) {
    return CatJsonData(
      map['id'],
      List<String>.from(map['tags']),
      map['created_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CatJsonData.fromJson(String source) => CatJsonData.fromMap(json.decode(source));

  @override
  String toString() => 'CatJsonData(id: $id, tags: $tags, created_at: $created_at)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CatJsonData &&
      other.id == id &&
      listEquals(other.tags, tags) &&
      other.created_at == created_at;
  }

  @override
  int get hashCode => id.hashCode ^ tags.hashCode ^ created_at.hashCode;
}
