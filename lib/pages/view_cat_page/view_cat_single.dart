import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basics_2/pages/view_cat_page/hiding_appbar_page.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/shared/widgets/action_buttons.dart';
import 'package:flutter_basics_2/shared/widgets/custom_appbar.dart';
import 'package:flutter_basics_2/utils/hero_tags.dart';
import 'package:photo_view/photo_view.dart';

class SingleCatViewPage extends StatefulWidget {
  final Cat cat;

  const SingleCatViewPage({Key? key, required this.cat}) : super(key: key);

  @override
  SingleCatViewPageState createState() => SingleCatViewPageState();
}

class SingleCatViewPageState extends State<SingleCatViewPage> {

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HidingAppBarPage(
      appBar: CustomAppbar(
        name: '',
        actions: [
          EditCatButton(
            cat: widget.cat,
            editorHeroTag: catHeroTag(cat: widget.cat),
          ),
          SaveCatButton(cat: widget.cat),
          ShareCatButton(cat: widget.cat),
        ],
      ),
      body: PhotoView(
        heroAttributes: PhotoViewHeroAttributes(tag: catHeroTag(cat: widget.cat)),
        imageProvider: CachedNetworkImageProvider(widget.cat.url),
        minScale: PhotoViewComputedScale.contained,
        maxScale: 10.0,
      ),
      onChangeVisibility: (isVisible) {
        if (isVisible)
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        else
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

      },
    );
  }
}
