import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_basics_2/widgets/sliding_appbar.dart';
import 'package:logger/logger.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CatViewPage extends StatefulWidget {
  String get _name => runtimeType.toString();
  final Album album;
  final int catIndex;

  const CatViewPage(
      {Key? key,
      required this.album,
      required this.catIndex})
      : super(key: key);

  @override
  _CatViewPageState createState() => _CatViewPageState();
}

class _CatViewPageState extends State<CatViewPage>
    with SingleTickerProviderStateMixin {
  var _showAppBar = false;
  late final AnimationController _appBarSlideController;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _appBarSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _pageController = PageController(initialPage: widget.catIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SlidingAppBar(
        child: AppBar(
          title: const Text('Look at this cat!'),
        ),
        visible: _showAppBar,
        controller: _appBarSlideController,
      ),
      body: GestureDetector(
        child: PhotoViewGallery.builder(
          itemCount: widget.album.cats.length,
          pageController: _pageController,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage('$BASE_URL${widget.album.cats[index].url}'),
               heroAttributes: PhotoViewHeroAttributes(tag: widget.album.cats[index].url),
              minScale: PhotoViewComputedScale.contained,
              maxScale: 10.0,
            );
          },
        ),
        onTap: () {
          setState(() {
            _showAppBar = !_showAppBar;
          });
        },
      ),
    );
  }
}
