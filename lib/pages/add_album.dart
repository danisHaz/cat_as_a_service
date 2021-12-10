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
  bool isError = false;

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
        padding: const EdgeInsets.all(18),
        children: [
          TextFormField(
            controller: _textController,
            autofocus: true,
            onChanged: (value) => setState(() {
              isError = false;
            }),
            decoration: InputDecoration(
              labelText: 'Album name',
              helperText: ' ',
              errorText: isError ? "Album name must not be empty" : null,
              border: const OutlineInputBorder(),
              suffixIcon: isError ? const Icon(
                Icons.error,
              ) : null,
            ),
          ),
          // TODO: fix button jump when error message appears
          ElevatedButton(
            onPressed: () {
              if(_textController.value.text.isEmpty){
                setState(() {
                  isError = true;
                });
                return;
              }
              context.read<AlbumsCubit>().addAlbum(_textController.value.text);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}
