import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/pages/base_error_page.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_basics_2/utils/hero_tags.dart';
import 'package:logger/logger.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CatPageBuilder {
  final CatPageData data;
  const CatPageBuilder({required this.data});

  Widget build() {
    if (data is FromAlbumData) {
      return FromAlbumBuilder(
          album: (data as FromAlbumData).album,
          catIndex: (data as FromAlbumData).chosenCatIndex);
    } else if (data is SinglePictureData) {
      return SinglePictureBuilder(cat: (data as SinglePictureData).cat);
    } else {
      throw UnimplementedError("Data type for 'Cat page' is not implemented");
    }
  }
}

abstract class CatPageData {}

@immutable
class FromAlbumData extends CatPageData {
  FromAlbumData({
    required this.album,
    required this.chosenCatIndex,
  });

  final Album album;
  final int chosenCatIndex;
}

@immutable
class SinglePictureData extends CatPageData {
  SinglePictureData({
    required this.cat,
  });

  final Cat cat;
}

class FromAlbumBuilder extends StatefulWidget {
  final album;
  final catIndex;
  String get _name => runtimeType.toString();

  const FromAlbumBuilder({
    Key? key,
    required this.album,
    required this.catIndex,
  }) : super(key: key);

  @override
  FromAlbumBuilderState createState() => FromAlbumBuilderState();
}

class FromAlbumBuilderState extends State<FromAlbumBuilder> {
  FromAlbumBuilderState() : super();
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.catIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      itemCount: widget.album.cats.length,
      pageController: _pageController,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(
            '$BASE_URL${widget.album.cats[index].url}',
            errorListener: () {
              Logger().e("Failed download image in ${widget._name}");
            },
          ),
          heroAttributes: PhotoViewHeroAttributes(
            tag: catHeroTag(
              album: widget.album,
              index: index,
            ),
          ),
          minScale: PhotoViewComputedScale.contained,
          maxScale: 10.0,
        );
      },
    );
  }
}

class SinglePictureBuilder extends StatelessWidget {
  final Cat cat;
  String get _name => runtimeType.toString();

  const SinglePictureBuilder({
    Key? key,
    required this.cat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      heroAttributes: PhotoViewHeroAttributes(tag: catHeroTag(cat: cat)),
      imageProvider: CachedNetworkImageProvider(
        '$BASE_URL${cat.url}',
        errorListener: () {
          Logger().e("Failed to download image in $_name");
        },
      ),
      minScale: PhotoViewComputedScale.contained,
      maxScale: 10.0,
    );
  }
}
