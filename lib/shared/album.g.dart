// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      json['id'] as String,
      json['name'] as String,
      (json['cats'] as List<dynamic>)
          .map((e) => CatJsonData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cats': instance.cats.map((e) => e.toJson()).toList(),
    };
