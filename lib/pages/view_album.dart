import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/blocs/albums_bloc.dart';
import 'package:flutter_basics_2/pages/view_cat.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';
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
            children: [for (var cat in album.cats) CatPreview(cat: cat)],
          ),
        );
      },
    );
  }
}

class CatPreview extends StatelessWidget {
  final Cat cat;
  final _heroTag = UniqueKey();
  CatPreview({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _heroTag,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('$BASE_URL${cat.url}'),
                fit: BoxFit.cover,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CatViewPage(
                            cat: cat,
                            heroTag: _heroTag,
                          )));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
