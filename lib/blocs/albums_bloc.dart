import 'dart:async';
import 'dart:math';

import 'package:flutter_basics_2/repositories/cat_repository.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      : super(initialState){
    _albumsSubscription = CatRepository().albumsStream().listen((event) {
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
    if (Random().nextBool()) {
      addCatToAlbum(albumId,
          Cat('612f9eeed81ee30011e05de9', [], "at the beginning of time"));
    }
  }

  void addCatToAlbum(String albumId, Cat cat) {
    CatRepository().addCatToAlbum(albumId, cat);
  }
}
