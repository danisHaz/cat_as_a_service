// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cat _$CatFromJson(Map<String, dynamic> json) => Cat(
      id: json['id'] as String,
      created_at: json['created_at'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$CatToJson(Cat instance) => <String, dynamic>{
      'id': instance.id,
      'tags': instance.tags,
      'created_at': instance.created_at,
      'url': instance.url,
    };
