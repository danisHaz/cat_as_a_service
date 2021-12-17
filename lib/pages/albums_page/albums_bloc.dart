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
    _albumsSubscription = CatRepository().albumsStream.listen((event) {
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

  Future<String> addAlbum(String name) => CatRepository().addAlbum(name);

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

  Future<void> removeCatFromAlbum(String albumId, int index) async {
    await CatRepository().removeCatFromAlbum(albumId, index);
  }

  Future<void> removeAlbum(String albumId) async{
    await CatRepository().removeAlbum(albumId);
  }

  Future<void> removeMultipleCatsFromAlbum(String albumId, List<int> catsIndices) async {
    await CatRepository().removeMultipleCatsFromAlbum(albumId, catsIndices);
  }
}
