import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_basics_2/repositories/api_service.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:logger/logger.dart';

// TODO: !IMPORTANT! rewrite albums as subcollections

class CatRepository {
  late final Dio _dio;
  late final ApiService _apiService;

  CatRepository() {
    _dio = Dio();
    _apiService = ApiService(_dio);
  }

  Future<Cat> getFilteredCat(Cat oldCat) =>
    _apiService.getFilteredSpecifiedCat(
      filter: oldCat.filter.emptyIfNull(),
      fontSize: oldCat.fontSize?.toString() ?? "",
      textColor: oldCat.textColor?.toString() ?? "",
      type: oldCat.type ?? "",
      id: oldCat.id,
    );

  Future<Cat> getRandomCat() =>
    _apiService.getCatJsonData(getJson: true);

  Future<List<String>> getAllTags() =>
    _apiService.getAllTags();

  Future<List<Cat>> getAllCatsByTag({
    required List<String> tags,
    int numberOfCatsToSkip = 0,
    int limitNumberOfCats = 10,
  }) =>
    _apiService.getAllCatsByTag(
      formattedTags: tags.join(","),
      numberOfCatsToSkip: numberOfCatsToSkip,
      limitNumberOfCats: limitNumberOfCats,
    );

  late final CollectionReference _albumsCollection;

  Stream<Map<String, Album>> albumsStream() {
    return (_albumsCollection.snapshots()
      as Stream<QuerySnapshot<Map<String, dynamic>>>)
      .transform(StreamTransformer.fromHandlers(handleData: (snapshot, sink) {
        final ret = <String, Album>{};
        for (var doc in snapshot.docs) {
          final album = Album.fromJson(doc.data());
          ret[album.id] = album;
        }
        sink.add(ret);
      })
    );
  }

  Future<String> addAlbum(String name) async {
    final id = _albumsCollection.doc().id;
    await _albumsCollection.doc(id).set(Album(id, name, []).toJson());
    return id;
  }

  Future<void> removeAlbum(String albumId) async {
    await _albumsCollection.doc(albumId).delete();
  }

  Future<void> addCatToAlbum(String albumId, Cat cat) async {
    final snapshot = await _albumsCollection.doc(albumId).get();
    final snapshotData = snapshot.data();
    final album = Album.fromJson(snapshotData as Map<String, dynamic>);
    album.cats.add(cat);
    await _albumsCollection.doc(albumId).update(album.toJson());
  }

  Future<void> removeCatFromAlbum(String albumId, int index) async {
    final snapshot = await _albumsCollection.doc(albumId).get();
    final snapshotData = snapshot.data();
    final album = Album.fromJson(snapshotData as Map<String, dynamic>);
    album.cats.removeAt(index);
    await _albumsCollection.doc(albumId).update(album.toJson());
  }

  Future<void> removeMultipleCatsFromAlbum(String albumId, List<int> catsIndices) async {
    final snapshot = await _albumsCollection.doc(albumId).get();
    final snapshotData = snapshot.data();
    final album = Album.fromJson(snapshotData as Map<String, dynamic>);
    catsIndices.sort();
    // Logger().d(catsIndices.length);
    for (int i = catsIndices.length-1; i >= 0; i--) {
      // Logger().d(catsIndices[i]);
      album.cats.removeAt(catsIndices[i]);
    }
    await _albumsCollection.doc(albumId).update(album.toJson());
  }

  Future<void> initialize() async {
    final auth = await FirebaseAuth.instance.signInAnonymously();
    final firestore = FirebaseFirestore.instance;
    _albumsCollection =
        firestore.collection('users').doc(auth.user!.uid).collection('albums');
  }
}
