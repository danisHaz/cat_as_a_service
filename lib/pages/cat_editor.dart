import 'dart:ffi';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/shared/cat_decoration.dart';
import 'package:flutter_basics_2/shared/widgets/custom_appbar.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_item.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_popup.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_basics_2/utils/hero_tags.dart';
import 'package:flutter_basics_2/widgets/progress_bar.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'add_cat_page/cat_save_dialog.dart';

class CatEditorPage extends StatefulWidget {
  final Cat cat;
  final String heroTag;
  const CatEditorPage({Key? key, required this.cat, this.heroTag = ''}) : super(key: key);

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

  Future<String> _getImagePath() async {
    final cache = DefaultCacheManager();
    final file = await cache.getSingleFile('$BASE_URL${cat.url}');
    return file.path;
  }

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
      cat = cat.copyWith(
          decoration: CatDecoration(
        text: _textController.value.text,
        filter: _selectedFilter,
      ));
    });
  }

  IconButton _buildSavePictureButton() {
    final buttonKey = GlobalKey();
    return IconButton(
      key: buttonKey,
      onPressed: () async {
        final func = await openDropdown(
          context,
          buttonKey,
          [
            DropdownItem(
              child: const Text(
                'Save to album',
                style: TextStyle(color: Colors.white),
              ),
              value: () async {
                final album = await showDialog(
                    context: context,
                    builder: (context) => CatSaveDialog(cat: cat));
                if (album != null && album is Album){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image saved to ${album.name}'),));
                }
              },
            ),
            DropdownItem(
              child: const Text(
                'Save to device',
                style: TextStyle(color: Colors.white),
              ),
              value: () async {
                await GallerySaver.saveImage(await _getImagePath());
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Image saved'),
                ));
              },
            ),
          ],
        );
        if (func != null) (func as Function())();
      },
      icon: const Icon(
        Icons.arrow_downward,
        size: 30,
      ),
    );
  }

  IconButton _buildShareButton() => IconButton(
        onPressed: () async {
          Share.shareFiles([await _getImagePath()]);
        },
        icon: const Icon(Icons.share),
      );

  Widget _buildPicture() => Center(
        child: Container(
          clipBehavior: Clip.antiAlias,
          constraints: BoxConstraints(maxHeight: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Hero(
            tag: widget.heroTag,
            child: CachedNetworkImage(
              // width: double.infinity,
              imageUrl: '$BASE_URL${cat.url}',
              progressIndicatorBuilder: (context, url, loadingProgress) {
                return Center(
                    child: ProgressBar(
                  loadingProgress: loadingProgress,
                ));
              },
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        name: 'Cat editor',
        actions: [
          _buildSavePictureButton(),
          _buildShareButton(),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildPicture(),
          Text('Text'),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(99999))),
              fillColor: Colors.grey[300],
              filled: true,
              hintText: 'Enter text',
              isDense: true,
            ),
            controller: _textController,
            onChanged: (value) {
              _updateDecoration();
            },
            autofocus: false,
          ),
          Text('Filters'),
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
          ),
        ],
      ),
    );
  }
}
