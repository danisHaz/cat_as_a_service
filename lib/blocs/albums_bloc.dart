import 'dart:math';

import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumsState {
  final Map<int, Album> albums;
  final int nextIndex;

  const AlbumsState({
    this.albums = const {},
    this.nextIndex = 0,
  });

  AlbumsState copyWith({
    Map<int, Album>? albums,
    int? nextIndex,
  }) {
    return AlbumsState(
      albums: albums ?? this.albums,
      nextIndex: nextIndex ?? this.nextIndex,
    );
  }
}

class AlbumsCubit extends Cubit<AlbumsState> {
  AlbumsCubit([AlbumsState initialState = const AlbumsState()])
      : super(initialState);

  void addAlbum(String name) {
    var newAlbums = Map.of(state.albums);
    newAlbums[state.nextIndex] = Album(state.nextIndex, name, []);

    final albumId = state.nextIndex;

    emit(AlbumsState(albums: newAlbums, nextIndex: state.nextIndex + 1));

    if (Random().nextBool()) {
      addCatToAlbum(albumId,
          Cat('612f9eeed81ee30011e05de9', [], "at the beginning of time"));
    }
  }

  void addCatToAlbum(int albumId, Cat cat) {
    var newAlbums = Map.of(state.albums);
    var album = newAlbums[albumId]!;
    var newAlbum = Album(album.id, album.name, List.of(album.cats));
    newAlbum.cats.add(cat);
    newAlbums[albumId] = newAlbum;

    emit(state.copyWith(albums: newAlbums));
  }
}
