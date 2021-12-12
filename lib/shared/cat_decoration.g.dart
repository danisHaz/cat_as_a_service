// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_decoration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatDecoration _$CatDecorationFromJson(Map<String, dynamic> json) =>
    CatDecoration(
      text: json['text'] as String,
      filter: $enumDecode(_$CatDecorationFilterEnumMap, json['filter']),
    );

Map<String, dynamic> _$CatDecorationToJson(CatDecoration instance) =>
    <String, dynamic>{
      'text': instance.text,
      'filter': _$CatDecorationFilterEnumMap[instance.filter],
    };

const _$CatDecorationFilterEnumMap = {
  CatDecorationFilter.none: 'none',
  CatDecorationFilter.sepia: 'sepia',
  CatDecorationFilter.blur: 'blur',
  CatDecorationFilter.mono: 'mono',
  CatDecorationFilter.negative: 'negative',
  CatDecorationFilter.paint: 'paint',
};
