import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/add_cat/cat_editor.dart';
import 'package:flutter_basics_2/pages/add_cat_page/cat_save_dialog.dart';
import 'package:flutter_basics_2/pages/albums_page/albums_bloc.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_item.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_popup.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../album.dart';
import '../cat.dart';

class SaveCatButton extends StatelessWidget {
  final Cat cat;

  const SaveCatButton({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonKey = GlobalKey();
    return IconButton(
      key: buttonKey,
      onPressed: () async {
        final func = await openDropdown(
          context,
          buttonKey,
          [
            DropdownItem(
              child: const Text(
                'Save to album',
                style: TextStyle(color: Colors.white),
              ),
              value: () async {
                final album = await showDialog(
                    context: context,
                    builder: (context) => CatSaveDialog(cat: cat));
                if (album != null && album is Album) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Image saved to ${album.name}'),
                  ));
                }
              },
            ),
            DropdownItem(
              child: const Text(
                'Save to device',
                style: TextStyle(color: Colors.white),
              ),
              value: () async {
                await GallerySaver.saveImage(await _getImagePath(cat));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Image saved'),
                ));
              },
            ),
          ],
        );
        if (func != null) (func as Function())();
      },
      icon: const Icon(
        Icons.arrow_downward,
        size: 30,
      ),
    );
  }
}

class ShareCatButton extends StatelessWidget {
  final Cat cat;

  const ShareCatButton({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        Share.shareFiles([await _getImagePath(cat)]);
      },
      icon: const Icon(Icons.share),
    );
  }
}

class EditCatButton extends StatelessWidget {
  final Cat cat;
  final String? editorHeroTag;

  const EditCatButton({Key? key, required this.cat, this.editorHeroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CatEditorPage(
            cat: cat,
            heroTag: editorHeroTag ?? '',
          ),
        ));
      },
      icon: const Icon(Icons.edit),
    );
  }
}

class DeleteCatButton extends StatelessWidget {
  final String albumId;
  final int index;

  const DeleteCatButton({Key? key, required this.albumId, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final result = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Are yo sure $index'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Delete'),
                ),
              ],
            );
          },
        );
        if (result == true) {
          context.read<AlbumsCubit>().removeCatFromAlbum(albumId, index);
        }
      },
      icon: const Icon(Icons.delete),
    );
  }
}

Future<String> _getImagePath(Cat cat) async {
  final cache = DefaultCacheManager();
  final file = await cache.getSingleFile('$BASE_URL${cat.url}');
  return file.path;
}
