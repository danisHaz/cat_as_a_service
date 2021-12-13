import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_basics_2/pages/album_page/albums_bloc.dart';
import 'package:flutter_basics_2/pages/album_page/view_album.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:dotted_border/dotted_border.dart';

import 'add_album.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlbumGrid(onTap: (album) {
        if(album.cats.isEmpty)return;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ViewAlbumPage(albumId: album.id);
          },
        ));
      },)
    );
  }
}

class AlbumGrid extends StatelessWidget {
  final Function(Album album) onTap;

  const AlbumGrid({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsCubit, AlbumsState>(
      builder: (context, state) {
        return GridView.count(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(16),
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return AddAlbumPage();
                  },
                ));
              },
              child: DottedBorder(
                padding: EdgeInsets.zero,
                borderType: BorderType.RRect,
                radius: Radius.circular(25),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    // border: Border.all(),
                    // borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: FittedBox(
                    child: Icon(Icons.add),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            for (var album in state.albums.values)
              GestureDetector(
                onTap: ()=> onTap(album),
                child: AlbumPreview(album),
              )
          ],
        );
      },
    );
  }
}

class AlbumPreview extends StatelessWidget {
  final Album album;
  const AlbumPreview(this.album, {Key? key}) : super(key: key);
  String get _name => runtimeType.toString();

  @override
  Widget build(BuildContext context) {
    final imageWidget = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        image: DecorationImage(
          image: album.cats.isNotEmpty
              ? CachedNetworkImageProvider(
                  '$BASE_URL/cat/${album.cats[0].id}',
                  errorListener: () {
                    Logger().e("Failed download image in ${_name}");
                  },
                )
              : AssetImage('assets/images/cat_placeholder.png')
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
    return Column(
      children: [
        Expanded(child: imageWidget),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                album.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
              Text(
                album.cats.length.toString(),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
