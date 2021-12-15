import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/albums_page/albums_bloc.dart';
import 'package:flutter_basics_2/shared/colors.dart';
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
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        name: 'add_album.name'.tr(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 0),
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                fillColor: backgroundGrey,
                helperText: ' ',
                errorText: isError ? "add_album.must_not_be_empty".tr() : null,
                filled: true,
                hintText: 'cat_editor.enter_text'.tr(),
                contentPadding: const EdgeInsets.all(15),
                isCollapsed: true,
                suffixIcon: isError
                    ? const Icon(
                        Icons.error,
                        color: Colors.red,
                      )
                    : null,
              ),
              controller: _textController,
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                isError = false;
              },
              autofocus: true,
            ),
          ),
          InkWell(
            onTap: () {
              if (_textController.value.text.isEmpty) {
                setState(() {
                  isError = true;
                });
                return;
              }
              context.read<AlbumsCubit>().addAlbum(_textController.value.text);
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: mainBlue),
              height: 52,
              child: Center(
                child: Text(
                  "add_album.add".tr(),
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
