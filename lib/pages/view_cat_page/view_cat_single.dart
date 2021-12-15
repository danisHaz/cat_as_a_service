import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/view_cat_page/hiding_appbar_page.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/shared/widgets/action_buttons.dart';
import 'package:flutter_basics_2/shared/widgets/custom_appbar.dart';
import 'package:flutter_basics_2/utils/hero_tags.dart';
import 'package:photo_view/photo_view.dart';

class SingleCatViewPage extends StatelessWidget {
  final Cat cat;
  final bool showActions;
  final String? heroTag;

  const SingleCatViewPage(
      {Key? key, required this.cat, this.showActions = true, this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HidingAppBarPage(
      appBar: CustomAppbar(
        name: '',
        actions: showActions
            ? [
                EditCatButton(
                  cat: cat,
                  editorHeroTag: catHeroTag(cat: cat),
                ),
                SaveCatButton(cat: cat),
                ShareCatButton(cat: cat),
              ]
            : [],
      ),
      body: PhotoView(
        heroAttributes:
            PhotoViewHeroAttributes(tag: heroTag ?? catHeroTag(cat: cat)),
        imageProvider: CachedNetworkImageProvider(cat.url),
        minScale: PhotoViewComputedScale.contained,
        maxScale: 10.0,
      ),
    );
  }
}
