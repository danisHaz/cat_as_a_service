import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/shared/cat.dart';

class CatRepository {
  static final CatRepository _instance = CatRepository._create();

  CatRepository._create();

  factory CatRepository() {
    return _instance;
  }

  late final CollectionReference _albumsCollection;

  Stream<Map<String, Album>> albumsStream() {
    return (_albumsCollection
        .snapshots() as Stream<QuerySnapshot<Map<String, dynamic>>>)
        .transform(StreamTransformer.fromHandlers(handleData: (snapshot, sink) {
      final ret = <String, Album>{};
      for (var doc in snapshot.docs) {
        final album = Album.fromJson(doc.data());
        ret[album.id] = album;
      }
      sink.add(ret);
    }));
  }

  Future<String> addAlbum(String name) async {
    final id = _albumsCollection.doc().id;
    await _albumsCollection.doc(id).set(Album(id, name, []).toJson());
    return id;
  }

  Future<void> addCatToAlbum(String albumId, Cat cat)async {
    final snapshot = await _albumsCollection.doc(albumId).get();
    final snapshotData = snapshot.data();
    final album = Album.fromJson(snapshotData as Map<String, dynamic>);
    album.cats.add(cat);
    await _albumsCollection.doc(albumId).update(album.toJson());
  }


  Future<void> initialize() async {
    final auth = await FirebaseAuth.instance.signInAnonymously();
    final firestore = FirebaseFirestore.instance;
    _albumsCollection =
        firestore.collection('users').doc(auth.user!.uid).collection('albums');
  }
}
