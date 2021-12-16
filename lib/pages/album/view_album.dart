import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/albums_page/albums_bloc.dart';
import 'package:flutter_basics_2/pages/view_cat_page/view_cat_album.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/shared/widgets/custom_appbar.dart';
import 'package:flutter_basics_2/shared/widgets/select_indicator.dart';
import 'package:flutter_basics_2/utils/hero_tags.dart';
import 'package:flutter_basics_2/widgets/cat_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewAlbumPage extends StatefulWidget {
  final String albumId;
  const ViewAlbumPage({Key? key, required this.albumId}) : super(key: key);

  @override
  ViewAlbumPageState createState() => ViewAlbumPageState();

}

enum ViewAlbumPageInfo {
  observing,
  deletion,
}

class ViewAlbumPageState extends State<ViewAlbumPage> {

  ViewAlbumPageInfo _info = ViewAlbumPageInfo.observing;
  late final List<Widget> Function(AlbumsState state, ViewAlbumPageInfo info) _buildActions;
  late final List<int> _catsIndices = [];

  void _changeInfo() {
    setState(() {
      _info = (_info == ViewAlbumPageInfo.deletion)
        ? ViewAlbumPageInfo.observing : ViewAlbumPageInfo.deletion;
    });
  }

  void _clearCatsIndices() {
    setState(() {
      _catsIndices.clear();
    });
  }

  void _onTrashPressed(AlbumsState state) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("view_album.remove_album".tr() + '"${state.albums[widget.albumId]?.name}"'),
          content: Text("view_album.are_you_sure".tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("view_album.cancel".tr()),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("view_album.delete".tr()),
            ),
          ],
        );
      },
    );
    if (result == true) {
      Navigator.of(context).pop();
      _changeInfo();
      _clearCatsIndices();
      context.read<AlbumsCubit>().removeAlbum(widget.albumId);
    }
  }

  void _onMultiplePicturesDelete() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("view_album.remove_many_pictures".tr()),
          content: Text("view_album.are_you_sure".tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("view_album.cancel".tr()),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("view_album.delete".tr()),
            ),
          ],
        );
      },
    );
    if (result == true) {
      _changeInfo();
      await context.read<AlbumsCubit>()
        .removeMultipleCatsFromAlbum(widget.albumId, _catsIndices);
      _clearCatsIndices();
    }
  }

  @override
  void initState() {
    _buildActions = (state, info) {
      final kek = [
        [
          IconButton(
            onPressed:() {
              _onTrashPressed(state);
            },
            icon: const Icon(FontAwesomeIcons.trash)
          )
        ],
        [
          IconButton(
            onPressed: _changeInfo,
            icon: const Icon(FontAwesomeIcons.times),
          )
        ],
      ];

      if (_info == ViewAlbumPageInfo.observing)
        return kek[0];
      
      return kek[1];
    };
    
  }

  Widget _buildCatPreview(Album album, int i) =>
    CatPreview(
      heroTag: catHeroTag(album: album, index: i),
      cat: album.cats[i],
      onTap: () {
        if (_info == ViewAlbumPageInfo.deletion) {
          setState(() {
            if (_catsIndices.contains(i))
              _catsIndices.remove(i);
            else
              _catsIndices.add(i);
          });
          return;
        }
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AlbumCatViewPage(
            albumId: album.id,
            startIndex: i,
          )
        ));
      },
      onLongPressed: () {
        if (_info == ViewAlbumPageInfo.observing) {
          _catsIndices.add(i);
          _changeInfo();
        }
      },
    );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsCubit, AlbumsState>(
      builder: (context, state) {
        final album = state.albums[widget.albumId];
        return Scaffold(
          appBar: CustomAppbar(
            name: album?.name ?? 'view_album.dead_album'.tr(),
            actions: _buildActions(state, _info),
            mainNavButton: _info == ViewAlbumPageInfo.deletion ? const Icon(
              FontAwesomeIcons.trash,
              size: 30,
            ) : null,
            onMainNavButtonPressed: _info == ViewAlbumPageInfo.deletion 
              ? _onMultiplePicturesDelete : null,
          ),
          body: album != null && album.cats.isNotEmpty ? GridView.count(
            physics: const BouncingScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
            childAspectRatio: 0.8,
            children: [
              for (var i = 0; i < album.cats.length; i++)
                if (_info == ViewAlbumPageInfo.observing)
                  _buildCatPreview(album, i)
                else
                  Stack(
                    children: [
                      _buildCatPreview(album, i),
                      StatelessSelectIndicator(
                        defaultState: ((){
                            if (_catsIndices.contains(i))
                              return SelectIndicatorInfo.enabled;
                            return SelectIndicatorInfo.disabled;
                          }()),
                      ),
                    ],
                  )
            ],
          ) : Center(
            child:  Text("view_album.empty_album".tr()),
          ),
        );
      },
    );
  }
}
