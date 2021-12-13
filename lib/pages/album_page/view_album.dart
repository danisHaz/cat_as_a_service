import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/album_page/albums_bloc.dart';
import 'package:flutter_basics_2/pages/view_cat_page/view_cat.dart';
import 'package:flutter_basics_2/pages/view_cat_page/view_cat_state.dart';
import 'package:flutter_basics_2/widgets/cat_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAlbumPage extends StatelessWidget {
  final String albumId;

  const ViewAlbumPage({Key? key, required this.albumId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsCubit, AlbumsState>(
      builder: (context, state) {
        final album = state.albums[albumId]!;
        return Scaffold(
          appBar: AppBar(
            title: Text(album.name),
          ),
          body: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 100,
            children: [
              for (var i = 0; i < album.cats.length; i++)
                CatPreview(
                  cat: album.cats[i],
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CatViewPage(
                          data: FromAlbumData(
                            album: album,
                            chosenCatIndex: i,
                          )
                        )
                      )
                    );
                  },
                )
            ],
          ),
        );
      },
    );
  }
}

