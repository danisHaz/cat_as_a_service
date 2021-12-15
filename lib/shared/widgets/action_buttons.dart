import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/add_cat/cat_editor.dart';
import 'package:flutter_basics_2/pages/add_cat/cat_save_dialog.dart';
import 'package:flutter_basics_2/pages/albums_page/albums_bloc.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_item.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_popup.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../album.dart';
import '../cat.dart';


class SaveCatButton extends StatelessWidget {
  final Cat cat;
  const SaveCatButton({Key? key, required this.cat}): super(key: key);

  Future<String> _getImagePath() async {
    final cache = DefaultCacheManager();
    final file = await cache.getSingleFile(cat.url);
    return file.path;
  }

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
              child: Container(
                width: 250,
                padding: const EdgeInsets.all(5),
                child: Text(
                  'action_buttons.save_to_album'.tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              value: () async {
                final album = await showDialog(
                    context: context,
                    builder: (context) => CatSaveDialog(cat: cat));
                if (album != null && album is Album) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      'action_buttons.image_saved_to'.tr() + album.name,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ));
                }
              },
            ),
            DropdownItem(
              child: Container(
                width: 250,
                padding: const EdgeInsets.all(5),
                child: Text(
                  'action_buttons.save_to_device'.tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              value: () async {
                try {
                  await GallerySaver.saveImage(await _getImagePath());
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      'action_buttons.image_saved'.tr(),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      e.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ));
                }
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
  final Function? onDelete;

  const DeleteCatButton({Key? key, required this.albumId, required this.index, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final result = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('action_buttons.remove_cat'.tr()),
              content: Text("action_buttons.are_you_sure".tr()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('action_buttons.cancel'.tr()),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('action_buttons.delete'.tr()),
                ),
              ],
            );
          },
        );
        if (result == true) {
          if(onDelete!= null)onDelete!();
          context.read<AlbumsCubit>().removeCatFromAlbum(albumId, index);
        }
      },
      icon: const Icon(Icons.delete),
    );
  }
}

Future<String> _getImagePath(Cat cat) async {
  final cache = DefaultCacheManager();
  final file = await cache.getSingleFile(cat.url);
  return file.path;
}
