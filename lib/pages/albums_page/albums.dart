import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_basics_2/pages/album/view_album.dart';
import 'package:flutter_basics_2/pages/albums_page/albums_bloc.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/utils/hero_tags.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../add_album/add_album.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: AlbumGrid(
        onTap: (album) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ViewAlbumPage(albumId: album.id);
            },
          ));
        },
      ),
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
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
          children: [
            Container(
              padding: const EdgeInsets.all(2.5),
              child: DottedBorder(
                padding: EdgeInsets.zero,
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [15, 5],
                strokeWidth: 5,
                color: Theme.of(context).iconTheme.color ?? Colors.black,
                child: Ink(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const AddAlbumPage();
                        },
                      ));
                    },
                    child: const Center(
                        child: Icon(
                      Icons.add,
                      size: 50,
                    )),
                  ),
                ),
              ),
            ),
            for (var album in state.albums.values)
              AlbumPreview(album, onTap: onTap)
          ],
        );
      },
    );
  }
}

class AlbumPreview extends StatelessWidget {
  final Function(Album) onTap;
  final Album album;

  const AlbumPreview(this.album, {Key? key, required this.onTap})
      : super(key: key);

  String get _name => runtimeType.toString();

  @override
  Widget build(BuildContext context) {
    final imageWidget = Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: album.cats.isNotEmpty
              ? CachedNetworkImageProvider(
                  album.cats[0].url,
                  errorListener: () {
                    Logger().e("Failed download image in $_name");
                  },
                )
              : const AssetImage('assets/images/cat_placeholder.png')
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onTap: () => onTap(album),
        ),
      ),
    );
    return Column(
      children: [
        Expanded(
          child: Hero(
            tag: catHeroTag(album: album, index: 0),
            child: imageWidget,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  album.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Text(
                album.cats.length.toString(),
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
