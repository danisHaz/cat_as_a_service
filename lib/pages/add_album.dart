import 'package:flutter/material.dart';
import 'package:flutter_basics_2/blocs/albums_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAlbumPage extends StatefulWidget {
  const AddAlbumPage({Key? key}) : super(key: key);

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
        title: const Text('Add Album'),
      ),
      body: ListView(
        children: [
          TextField(
            autofocus: true,
            controller: _textController,
          ),
          TextButton(
            onPressed: () {
              context.read<AlbumsCubit>().addAlbum(_textController.value.text);
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}
