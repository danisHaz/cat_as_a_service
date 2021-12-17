// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cat _$CatFromJson(Map<String, dynamic> json) => Cat(
      id: json['id'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      textColor: json['textColor'] as String?,
      fontSize: (json['fontSize'] as num?)?.toDouble(),
      text: json['text'] as String?,
      filter: $enumDecodeNullable(_$CatDecorationFilterEnumMap, json['filter']),
      type: json['type'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CatToJson(Cat instance) => <String, dynamic>{
      'id': instance.id,
      'tags': instance.tags,
      'textColor': instance.textColor,
      'fontSize': instance.fontSize,
      'text': instance.text,
      'filter': _$CatDecorationFilterEnumMap[instance.filter],
      'type': instance.type,
      'height': instance.height,
      'width': instance.width,
    };

const _$CatDecorationFilterEnumMap = {
  CatDecorationFilter.none: 'none',
  CatDecorationFilter.sepia: 'sepia',
  CatDecorationFilter.blur: 'blur',
  CatDecorationFilter.mono: 'mono',
  CatDecorationFilter.negative: 'negative',
  CatDecorationFilter.paint: 'paint',
};
