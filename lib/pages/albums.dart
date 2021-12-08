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
      appBar: AppBar(
        title: const Text('Albums'),
      ),
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
    var imageWidget = album.cats.isNotEmpty
        ? Image(
            image: NetworkImage('https://cataas.com/cat/${album.cats[0].id}'),
            fit: BoxFit.fill,
          )
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
