import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/pages/albums_page/albums_bloc.dart';
import 'package:flutter_basics_2/pages/base_error_page.dart';
import 'package:flutter_basics_2/pages/view_cat_page/view_cat_single.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/hero_tags.dart';
import 'package:flutter_basics_2/widgets/progress_bar.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class FeedListItem extends StatefulWidget {
  final Cat cat;
  const FeedListItem({Key? key, required this.cat}) : super(key: key);

  @override
  FeedListItemState createState() => FeedListItemState();
}

class FeedListItemState extends State<FeedListItem> {
  FlareControls flareControls = FlareControls();

  void _onDoubleTapOnCat() {
    flareControls.play("like");
    String? id =
        context.read<AlbumsCubit>().getAlbumIdByName("favourite_album".tr());
    if (id == null) {
      return;
    }
    context.read<AlbumsCubit>().addCatToAlbum(id, widget.cat);
  }


  void _onTapOnCat() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SingleCatViewPage(
              cat: widget.cat,
            )));
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Column(
        children: [
          // _buildTags(),
          GestureDetector(
              onDoubleTap: _onDoubleTapOnCat,
              onTap: _onTapOnCat,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Hero(
                      tag: catHeroTag(cat: widget.cat),
                      child: CachedNetworkImage(
                        imageUrl: widget.cat.url,
                        placeholder: (context, url) {
                          return const ProgressBar();
                        },
                        fadeOutDuration: const Duration(microseconds: 0),
                        fadeInDuration: const Duration(microseconds: 0),
                        placeholderFadeInDuration: const Duration(microseconds: 0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 220.0,
                    child: FlareActor(
                      'assets/animations/instagram_like.flr',
                      controller: flareControls,
                      animation: 'idle',
                    ),
                  ),
                ],
              )),
          // Container(height: 30),
        ],
      );
    } catch (e) {
      Logger().d("$e");
      return const BaseErrorPage();
    }
  }
}
