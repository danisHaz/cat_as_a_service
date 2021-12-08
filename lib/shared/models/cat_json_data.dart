import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../cat.dart';

class CatJsonData {
	final String id;
	final List<String> tags;
	final String createdAt;
	CatJsonData(
		this.id,
		this.tags,
		this.createdAt
	);

	Cat convertToCat() => Cat(id, tags, createdAt);

  CatJsonData copyWith({
    String? id,
    List<String>? tags,
    String? createdAt,
  }) {
    return CatJsonData(
      id ?? this.id,
      tags ?? this.tags,
      createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tags': tags,
      'created_at': createdAt,
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
  String toString() => 'CatJsonData(id: $id, tags: $tags, created_at: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CatJsonData &&
      other.id == id &&
      listEquals(other.tags, tags) &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ tags.hashCode ^ createdAt.hashCode;
}
