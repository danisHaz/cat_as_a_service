

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AlbumsState{
  final Map<int, Album> albums;
  final int nextIndex;

  const AlbumsState({
    this.albums = const {},
    this.nextIndex = 0,
  });

  AlbumsState copyWith({
    Map<int, Album>? albums,
    int? nextIndex,
  }){
    return AlbumsState(
      albums: albums??this.albums,
      nextIndex: nextIndex??this.nextIndex,
    );
  }
}


class AlbumsCubit extends Cubit<AlbumsState>{
  AlbumsCubit([AlbumsState initialState = const AlbumsState()]) : super(initialState);

  void addAlbum(String name){
    var newAlbums = Map.of(state.albums);
    newAlbums[state.nextIndex] = Album(state.nextIndex, name, []);

    var albumId = state.nextIndex;

    emit(AlbumsState(albums: newAlbums, nextIndex: state.nextIndex + 1));

    if(Random().nextBool()){
      addCatToAlbum(albumId, Cat('612f9eeed81ee30011e05de9', [], "at the beginning of time"));
    }
  }

  void addCatToAlbum(int albumId, Cat cat){
    var newAlbums = Map.of(state.albums);
    var album = newAlbums[albumId]!;
    var newAlbum = Album(album.id, album.name, List.of(album.cats));
    newAlbum.cats.add(cat);
    newAlbums[albumId] = newAlbum;

    emit(state.copyWith(albums: newAlbums));
  }

}


class AlbumsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: BlocBuilder<AlbumsCubit, AlbumsState>(
        builder: (context, state){
          return GridView.count(
            crossAxisCount: 2,
            children: [
              for(var album in state.albums.values)
                AlbumPreview(album)
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddAlbumPage();
          }));
        },
      ),
    );
  }
}

class AlbumPreview extends StatelessWidget{
  final Album album;
  AlbumPreview(this.album);

  @override
  Widget build(BuildContext context) {
    var imageWidget = album.cats.isNotEmpty ?  Image(image: NetworkImage('https://cataas.com/cat/${album.cats[0].id}'), fit: BoxFit.fill,)
        : Icon(Icons.wallpaper);

    return Card(
      child: Column(
        children: [
          Flexible(child: imageWidget),

          
          Row(
            children: [
              Text(album.name),
              Text(album.cats.length.toString()),
            ],
          )
        ],
      ),
    );
  }
}

class AddAlbumPage extends StatefulWidget{
  @override
  State<AddAlbumPage> createState() => _AddAlbumPageState();
}

class _AddAlbumPageState extends State<AddAlbumPage> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Album'),
      ),
      body: ListView(
        children: [
          TextField(
            controller: _textController,
          ),
          TextButton(
              onPressed: (){
                context.read<AlbumsCubit>().addAlbum(_textController.value.text);
                Navigator.of(context).pop();
              },
              child: Text('Add'),
          )
        ],
      ),
    );
  }
}

