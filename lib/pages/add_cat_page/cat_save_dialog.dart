import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/album_page/albums_bloc.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatSaveDialog extends StatelessWidget {
  final Cat cat;

  const CatSaveDialog({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsCubit, AlbumsState>(builder: (context, state) {
      return SimpleDialog(
        title: const Text('Select save location'),
        children: [
          _SimpleDialogItem(
            onPressed: () {
              // GallerySaver.saveImage('$BASE_URL${cat.url}');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Not implemented')),
              );
              Navigator.of(context).pop();
            },
            circleAvatar: const CircleAvatar(
              child: Icon(Icons.download),
            ),
            text: const Text('Save to gallery'),
          ),
          for (final album in state.albums.values)
            _SimpleDialogItem(
              onPressed: () {
                context.read<AlbumsCubit>().addCatToAlbum(album.id, cat);
                Navigator.of(context).pop();
              },
              circleAvatar: album.cats.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage:
                          NetworkImage('$BASE_URL${album.cats[0].url}'),
                    )
                  : const CircleAvatar(
                      child: Icon(Icons.wallpaper),
                    ),
              text: Text(album.name),
            ),
        ],
      );
    });
  }
}

class _SimpleDialogItem extends StatelessWidget {
  const _SimpleDialogItem(
      {Key? key,
      required this.onPressed,
      required this.circleAvatar,
      required this.text})
      : super(key: key);

  final Widget circleAvatar;
  final Widget text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          circleAvatar,
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: text,
          ),
        ],
      ),
    );
  }
}
