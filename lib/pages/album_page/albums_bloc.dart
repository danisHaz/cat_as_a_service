import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/repositories/cat_repository.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';

class AlbumsState {
  final Map<String, Album> albums;

  const AlbumsState({
    this.albums = const {},
  });

  AlbumsState copyWith({
    Map<String, Album>? albums,
    int? nextIndex,
  }) {
    return AlbumsState(
      albums: albums ?? this.albums,
    );
  }
}

class AlbumsCubit extends Cubit<AlbumsState> {
  late final StreamSubscription<dynamic> _albumsSubscription;

  AlbumsCubit([AlbumsState initialState = const AlbumsState()])
      : super(initialState) {
    _albumsSubscription = CatRepository().albumsStream().listen((event) {
      if (event.isEmpty) {
        addAlbum("favourite_album".tr());
      }
      emit(AlbumsState(albums: event));
    });
  }

  @override
  Future<void> close() {
    _albumsSubscription.cancel();
    return super.close();
  }

  void addAlbum(String name) async {
    final albumId = await CatRepository().addAlbum(name);
    final count = Random().nextInt(6);
    for (var i = 0; i < count; i++) {
      await addCatToAlbum(
          albumId,
          Cat(
              id: "61009bfccaacc400184f6b38",
              created_at: "2021-07-27T23:51:23.991Z",
              tags: const ["alcoholic"],
              url: "/cat/61009bfccaacc400184f6b38"));
    }
  }

  String? getAlbumIdByName(String albumName) {
    for (var albumEntry in state.albums.entries) {
      if (albumEntry.value.name == albumName) {
        return albumEntry.value.id;
      }
    }

    return null;
  }

  Future<void> addCatToAlbum(String albumId, Cat cat) async {
    await CatRepository().addCatToAlbum(albumId, cat);
  }
}
