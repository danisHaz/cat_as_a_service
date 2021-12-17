import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/shared/cat.dart';

String catHeroTag({Album? album, int? index, Cat? cat}) {
  if (album != null && index != null) {
    return '${album.id}_${index}';
  } else if (cat != null) {
    return cat.url;
  }
  return '';
}
