import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/blocs/albums_bloc.dart';
import 'package:flutter_basics_2/pages/view_cat.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_basics_2/widgets/cat_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAlbumPage extends StatelessWidget {
  final String albumId;

  const ViewAlbumPage({Key? key, required this.albumId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsCubit, AlbumsState>(
      builder: (context, state) {
        final album = state.albums[albumId]!;
        return Scaffold(
          appBar: AppBar(
            title: Text(album.name),
          ),
          body: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 100,
            children: [
              for (var cat in album.cats)
                CatPreview(
                  cat: cat.toCat(),
                  onTap: (tag){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CatViewPage(
                          cat: cat.toCat(),
                          heroTag: tag,
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

