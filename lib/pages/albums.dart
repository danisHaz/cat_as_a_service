import 'package:flutter/material.dart';
import 'package:flutter_basics_2/blocs/albums_bloc.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_album.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AlbumsCubit, AlbumsState>(
        builder: (context, state) {
          return GridView.count(
            crossAxisCount: 2,
            children: [
              for (var album in state.albums.values) AlbumPreview(album)
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const AddAlbumPage();
          }));
        },
      ),
    );
  }
}

class AlbumPreview extends StatelessWidget {
  final Album album;

  const AlbumPreview(this.album, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageWidget = album.cats.isNotEmpty
        ? Image.network('https://cataas.com/cat/${album.cats[0].id}')
        : const Icon(Icons.wallpaper);

    return Card(
      child: Column(
        children: [
          Flexible(child: imageWidget),
          Row(
            children: [
              Text(album.name),
              Text(album.cats.length.toString()),
            ],
          )
        ],
      ),
    );
  }
}
