import 'package:easy_localization/src/public_ext.dart';
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



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsCubit, AlbumsState>(
      builder: (context, state) {
        final album = state.albums[albumId];
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppbar(
            name: album?.name ?? 'view_album.dead_album'.tr(),
            actions: [
              IconButton(
                  onPressed: () async {
                    final result = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("view_album.remove_album".tr() + '"${album?.name}"'),
                          content: Text("view_album.are_you_sure".tr()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text("view_album.cancel".tr()),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text("view_album.delete".tr()),
                            ),
                          ],
                        );
                      },
                    );
                    if (result == true) {
                      Navigator.of(context).pop();
                      context.read<AlbumsCubit>().rmoveAlbum(albumId);
                    }
                  },
                  icon: const Icon(FontAwesomeIcons.trash))
            ],
          ),
          body: album != null && album.cats.isNotEmpty ? GridView.count(
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
          ) : Center(
            child:  Text("view_album.empty_album".tr()),
          ),
        );
      },
    );
  }
}
