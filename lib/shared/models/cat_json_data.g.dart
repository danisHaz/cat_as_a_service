// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_json_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatJsonData _$CatJsonDataFromJson(Map<String, dynamic> json) => CatJsonData(
      json['id'] as String,
      (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      json['created_at'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$CatJsonDataToJson(CatJsonData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tags': instance.tags,
      'created_at': instance.created_at,
      'url': instance.url,
    };
