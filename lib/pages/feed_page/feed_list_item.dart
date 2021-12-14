import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/pages/albums_page/albums_bloc.dart';
import 'package:flutter_basics_2/pages/base_error_page.dart';
import 'package:flutter_basics_2/pages/view_cat_page/view_cat.dart';
import 'package:flutter_basics_2/pages/view_cat_page/view_cat_state.dart';
import 'package:flutter_basics_2/repositories/cat_repository.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_basics_2/utils/hero_tags.dart';
import 'package:flutter_basics_2/widgets/progress_bar.dart';
import 'package:logger/logger.dart';
import 'package:provider/src/provider.dart';

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
    const favouritesTranslated = "Favourites";
    String? id =
        context.read<AlbumsCubit>().getAlbumIdByName(favouritesTranslated);
    if (id == null) {
      return;
    }
    CatRepository().addCatToAlbum(id, widget.cat);
  }

  Widget _buildTags() => Align(
      alignment: Alignment.topLeft,
      child: Padding(
          padding: const EdgeInsets.only(
            left: 2,
            bottom: 2,
            top: 20.0,
          ),
          child: Text(widget.cat.tags.join(", "),
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
              ))));

  void _onTapOnCat() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CatViewPage(
                data: SinglePictureData(
              cat: widget.cat,
            ))));
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
                        imageUrl: '$BASE_URL${widget.cat.url}',
                        placeholder: (context, url) {
                          return const ProgressBar();
                        },
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
          Container(height: 30),
        ],
      );
    } catch (e) {
      Logger().d("$e");
      return const BaseErrorPage();
    }
  }
}
