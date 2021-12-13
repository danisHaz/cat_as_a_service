import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/shared/cat_decoration.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_basics_2/widgets/progress_bar.dart';

import 'add_cat_page/cat_save_dialog.dart';

class CatEditorPage extends StatefulWidget {
  final Cat cat;
  const CatEditorPage({Key? key, required this.cat}) : super(key: key);

  @override
  _CatEditorPageState createState() => _CatEditorPageState();
}

class _CatEditorPageState extends State<CatEditorPage> {
  late Cat cat;
  late final TextEditingController _textController;
  static const _filterNames = {
    CatDecorationFilter.none: 'No filters',
    CatDecorationFilter.blur: 'Blur',
    CatDecorationFilter.mono: 'Monochrome',
    CatDecorationFilter.negative: 'Negative',
    CatDecorationFilter.paint: 'Paint',
    CatDecorationFilter.sepia: 'Sepia',
  };
  var _selectedFilter = CatDecorationFilter.none;

  @override
  void initState() {
    super.initState();
    cat = widget.cat;
    _selectedFilter = cat.decoration.filter;
    _textController = TextEditingController(text: cat.decoration.text);
  }

  // TODO: debouncer
  void _updateDecoration() {
    setState(() {
      cat = cat.copyWith(decoration: CatDecoration(
        text: _textController.value.text,
        filter: _selectedFilter,
      ));
    });
  }

  IconButton _getSavePictureButton() => IconButton(
    onPressed: () => {
      showDialog(
          context: context,
          builder: (context) => CatSaveDialog(
            cat: cat,
          )),
    },
    icon: const Icon(Icons.save),
  );

  Widget _getPicture() => Expanded(
    child: CachedNetworkImage(
      imageUrl: '$BASE_URL${cat.url}',
      progressIndicatorBuilder: (context, url, loadingProgress) {
        return Center(
          child: ProgressBar(loadingProgress: loadingProgress,)
        );
      },
    ),
  );

  Widget _getFiltersWidget() => Expanded(
    child: ListView(
      children: [
        TextFormField(
          controller: _textController,
          onChanged: (value) {
            _updateDecoration();
          },
        ),
        Wrap(
          children: _filterNames.entries.map((e) {
            if (e.key == _selectedFilter) {
              return ElevatedButton(
                  onPressed: () => {}, child: Text(e.value));
            } else {
              return OutlinedButton(
                  onPressed: () {
                    _selectedFilter = e.key;
                    _updateDecoration();
                  },
                  child: Text(e.value));
            }
          }).toList(),
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat editor'),
        actions: [
          _getSavePictureButton(),
        ],
      ),
      body: Column(
        children: [
          _getPicture(),
          _getFiltersWidget(),
        ],
      ),
    );
  }
}