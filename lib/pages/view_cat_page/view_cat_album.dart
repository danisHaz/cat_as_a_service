import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/albums_page/albums_bloc.dart';
import 'package:flutter_basics_2/pages/view_cat_page/hiding_appbar_page.dart';
import 'package:flutter_basics_2/shared/widgets/action_buttons.dart';
import 'package:flutter_basics_2/shared/widgets/custom_appbar.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_basics_2/utils/hero_tags.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AlbumCatViewPage extends StatefulWidget {
  final String albumId;
  final int startIndex;

  const AlbumCatViewPage(
      {Key? key, required this.albumId, required this.startIndex})
      : super(key: key);

  @override
  _AlbumCatViewPageState createState() => _AlbumCatViewPageState();
}

class _AlbumCatViewPageState extends State<AlbumCatViewPage> {
  late final PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.startIndex);
    currentPage = widget.startIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsCubit, AlbumsState>(builder: (context, state) {
      final album = state.albums[widget.albumId]!;

      final cat = album.cats[currentPage];

      return HidingAppBarPage(
        appBar: CustomAppbar(
          name: '',
          actions: [
            DeleteCatButton(
              albumId: widget.albumId,
              index: currentPage,
              onDelete: (){
                setState(() {
                  if(album.cats.length == 1){
                    Navigator.of(context).pop();
                  }
                  if(currentPage >= album.cats.length - 1){
                    _pageController.jumpToPage(currentPage - 1);
                  }
                });
              },
            ),
            EditCatButton(
              cat: cat,
              editorHeroTag: catHeroTag(
                album: album,
                index: currentPage,
              ),
            ),
            SaveCatButton(cat: cat),
            ShareCatButton(cat: cat),
          ],
        ),
        body: PhotoViewGallery.builder(
          itemCount: max(album.cats.length, currentPage),
          pageController: _pageController,
          onPageChanged: (page) => setState(() {
            currentPage = page;
          }),
          builder: (context, index) {
            if (index < album.cats.length) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(
                    '$BASE_URL${album.cats[index].url}'),
                heroAttributes: PhotoViewHeroAttributes(
                  tag: catHeroTag(
                    album: album,
                    index: index,
                  ),
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: 10.0,
              );
            } else {
              return PhotoViewGalleryPageOptions.customChild(
                child: null,
                maxScale: 1.0,
                minScale: 1.0,
              );
            }
          },
        ),
      );
    });
  }
}
