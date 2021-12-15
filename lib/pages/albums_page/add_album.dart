import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/albums_page/albums_bloc.dart';
import 'package:flutter_basics_2/shared/widgets/custom_appbar.dart';
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
      appBar: CustomAppbar(
        name:'add_album.name'.tr(),
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
              labelText: "add_album.label_text".tr(),
              helperText: ' ',
              errorText: isError ? "add_album.must_not_be_empty".tr() : null,
              border: const OutlineInputBorder(),
              suffixIcon: isError ? const Icon(
                Icons.error,
              ) : null,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_textController.value.text.isEmpty) {
                setState(() {
                  isError = true;
                });
                return;
              }
              context.read<AlbumsCubit>().addAlbum(_textController.value.text);
              Navigator.pop(context);
            },
            child: Text("add_album.add".tr()),
          )
        ],
      ),
    );
  }
}
