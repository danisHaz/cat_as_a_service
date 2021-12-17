import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:logger/logger.dart';

class CatPreview extends StatelessWidget {
  final Cat cat;
  void Function()? onTap;
  final String heroTag;
  void Function()? onLongPressed;

  CatPreview({
    Key? key,
    required this.cat,
    this.onTap,
    this.heroTag = '',
    this.onLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  cat.url,
                  errorListener: () {
                    Logger().e("Fail download image in cat_preview");
                  },
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
                onLongPress:() {
                  if (onLongPressed != null) onLongPressed!();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
