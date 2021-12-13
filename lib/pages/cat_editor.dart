import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/shared/cat_decoration.dart';
import 'package:flutter_basics_2/utils/consts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat editor'),
        actions: [
          IconButton(
            onPressed: () => {
              showDialog(
                  context: context,
                  builder: (context) => CatSaveDialog(
                        cat: cat,
                      )),
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.network('$BASE_URL${cat.url}', loadingBuilder:
                (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? max(
                          loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!,
                          0.2)
                      : null,
                ),
              );
            }),
          ),
          Expanded(
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
          ),
        ],
      ),
    );
  }
}