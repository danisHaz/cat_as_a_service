import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/album_page/albums.dart';
import 'package:flutter_basics_2/pages/album_page/albums_bloc.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:logger/logger.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CatSaveDialog extends StatelessWidget {
  final Cat cat;
  String get _name => runtimeType.toString();

  const CatSaveDialog({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsCubit, AlbumsState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Choose album'),
        ),
        body: AlbumGrid(
          onTap: (album) {
            context.read<AlbumsCubit>().addCatToAlbum(album.id, cat);
            Navigator.pop(context, album);
          },
        ),
      );
    });
  }
}