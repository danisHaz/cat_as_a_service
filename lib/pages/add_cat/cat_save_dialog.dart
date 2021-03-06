import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/albums_page/albums.dart';
import 'package:flutter_basics_2/pages/albums_page/albums_bloc.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/shared/widgets/custom_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatSaveDialog extends StatelessWidget {
  final Cat cat;

  const CatSaveDialog({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsCubit, AlbumsState>(builder: (context, state) {
      return Scaffold(
        appBar: CustomAppbar(
          name: 'cat_save_dialog.choose_album'.tr(),
        ),
        body: AlbumGrid(
          onTap: (album) {
            context.read<AlbumsCubit>().addCatToAlbum(album.id, cat);
            Navigator.pop(context, album);
          },
        ),
      );
    });
  }
}
