import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 2),
            crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
            children: [
              for (var album in state.albums.values) AlbumPreview(album)
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) {
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
        ? Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    NetworkImage('https://cataas.com/cat/${album.cats[0].id}'),
                fit: BoxFit.cover,
              ),
            ),
          )
        : FittedBox(
            child: const Icon(Icons.wallpaper),
            fit: BoxFit.contain,
          );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          print("Album tapped!");
        },
        child: Column(
          children: [
            Expanded(
              child: imageWidget,
            ),
            // imageWidget,
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      album.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )),
                    Text(album.cats.length.toString()),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
