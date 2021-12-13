import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:logger/logger.dart';

class CatPreview extends StatelessWidget {
  final Cat cat;
  void Function()? onTap;
  final String heroTag;
  CatPreview({Key? key, required this.cat, this.onTap, this.heroTag = '', }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  '$BASE_URL${cat.url}',
                  errorListener: () {
                    Logger().e("Fail download image in cat_preview");
                  },
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (onTap != null) onTap!();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
