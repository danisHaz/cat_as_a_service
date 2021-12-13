// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cat _$CatFromJson(Map<String, dynamic> json) => Cat(
      id: json['id'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      decoration: Cat._readDecoration(json, 'decoration') == null
          ? const CatDecoration(text: '', filter: CatDecorationFilter.none)
          : CatDecoration.fromJson(
              Cat._readDecoration(json, 'decoration') as Map<String, dynamic>),
    );

Map<String, dynamic> _$CatToJson(Cat instance) => <String, dynamic>{
      'id': instance.id,
      'tags': instance.tags,
      'decoration': instance.decoration.toJson(),
    };
