import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basics_2/pages/albums_page/albums_bloc.dart';
import 'package:flutter_basics_2/pages/view_cat_page/view_cat_album.dart';
import 'package:flutter_basics_2/shared/widgets/custom_appbar.dart';
import 'package:flutter_basics_2/utils/hero_tags.dart';
import 'package:flutter_basics_2/widgets/cat_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewAlbumPage extends StatelessWidget {
  final String albumId;

  const ViewAlbumPage({Key? key, required this.albumId}) : super(key: key);

  _delete() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsCubit, AlbumsState>(
      builder: (context, state) {
        final album = state.albums[albumId]!;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppbar(
            name: album.name,
            actions: [
              IconButton(
                  onPressed: () {
                    _delete();
                  },
                  icon: const Icon(FontAwesomeIcons.trash))
            ],
          ),
          body: GridView.count(
            physics: const BouncingScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
            childAspectRatio: 0.8,
            children: [
              for (var i = 0; i < album.cats.length; i++)
                CatPreview(
                  heroTag: catHeroTag(album: album, index: i),
                  cat: album.cats[i],
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AlbumCatViewPage(
                              albumId: album.id,
                              startIndex: i,
                            )));
                  },
                )
            ],
          ),
        );
      },
    );
  }
}
