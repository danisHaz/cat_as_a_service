import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_basics_2/pages/add_cat/cat_save_dialog.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/shared/colors.dart';
import 'package:flutter_basics_2/shared/widgets/custom_appbar.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_item.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_popup.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_basics_2/widgets/progress_bar.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CatEditorPage extends StatefulWidget {
  final Cat cat;
  final String heroTag;
  const CatEditorPage({Key? key, required this.cat, this.heroTag = ''})
      : super(key: key);

  @override
  _CatEditorPageState createState() => _CatEditorPageState();
}

class _CatEditorPageState extends State<CatEditorPage> {
  late Cat cat;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _fontSizeController = TextEditingController();
  final TextEditingController _fontColorController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  
  var _selectedFilter = CatDecorationFilter.none;

  final filterKey = GlobalKey();
  final colorKey = GlobalKey();

  String _generateUrl() {
    String finalUrl
      = "$BASE_URL${cat.url}" +
        (cat.text?.emptyIfNull().isEmpty == true ? "" : "/says/${cat.text}")
        + "?filter=${cat.filter.emptyIfNull()}"
        + "&color=${cat.textColor.emptyIfNull()}&type=${cat.type.emptyIfNull()}"
        + "&size=${cat.fontSize ?? ""}&height=${cat.height ?? ""}&width=${cat.width ?? ""}";
    return finalUrl;
  }

  Future<String> _getImagePath() async {
    final cache = DefaultCacheManager();
    final file = await cache.getSingleFile(_generateUrl());
    return file.path;
  }

  @override
  void initState() {
    super.initState();
    cat = widget.cat;
    _selectedFilter = cat.filter ?? CatDecorationFilter.none;
    _textController.text = cat.text.emptyIfNull();
  }

  // TODO: debouncer
  void _updateDecoration() {
    setState(() {
      cat = cat.copyWith(
        text: _textController.value.text,
        filter: _selectedFilter,
      );
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
              child: Container(
                width: 250,
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Save to album',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              value: () async {
                final album = await showDialog(
                    context: context,
                    builder: (context) => CatSaveDialog(cat: cat));
                if (album != null && album is Album) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      'Image saved to ${album.name}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ));
                }
              },
            ),
            DropdownItem(
              child: Container(
                width: 250,
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Save to device',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              value: () async {
                try {
                  await GallerySaver.saveImage(await _getImagePath());
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      'Image saved',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      e.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ));
                }
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

  _showFilters() async {
    final filters = _selectedFilter.customMap((e) {
      return DropdownItem(
          child: Container(
            width: 250,
            padding: const EdgeInsets.all(5),
            child: Text(
              e.emptyIfNull(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          value: e);
    }).toList();

    final rez = await openDropdown(context, filterKey, filters);
    if (rez != null) {
      _selectedFilter = rez;
      _updateDecoration();
    }
  }

  IconButton _buildShareButton() => IconButton(
        onPressed: () async {
          Share.shareFiles([await _getImagePath()]);
        },
        icon: const Icon(Icons.share),
      );

  Widget _buildPicture() => Container(
        clipBehavior: Clip.antiAlias,
        height: 300,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Hero(
          tag: widget.heroTag,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            // width: double.infinity,
            imageUrl: _generateUrl(),
            progressIndicatorBuilder: (context, url, loadingProgress) {
              return Center(
                  child: ProgressBar(
                loadingProgress: loadingProgress,
              ));
            },
          ),
        ),
      );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(
          name: 'Cat editor',
          actions: [
            _buildSavePictureButton(),
            _buildShareButton(),
          ],
        ),
        body: KeyboardDismissOnTap(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildPicture(),
              Container(height: 22),
              const Text(
                'Text: ',
                style: TextStyle(fontSize: 24),
              ),
              Container(height: 2),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fillColor: backgroundGrey,
                        filled: true,
                        hintText: 'Enter text',
                        contentPadding: EdgeInsets.all(15),
                        isCollapsed: true,
                      ),
                      controller: _textController,
                      style: const TextStyle(fontSize: 18),
                      onChanged: (value) {
                        _updateDecoration();
                      },
                    ),
                  ),
                  Container(width: 5),
                  Container(
                    width: 65,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fillColor: backgroundGrey,
                        filled: true,
                        hintText: '30',
                        contentPadding: EdgeInsets.all(15),
                        isCollapsed: true,
                      ),
                      keyboardType: TextInputType.number,
                      controller: _fontSizeController,
                      style: const TextStyle(fontSize: 18),
                      onChanged: (value) {
                        _updateDecoration();
                      },
                    ),
                  ),
                  Container(width: 5),
                  Container(
                    width: 110,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fillColor: backgroundGrey,
                        filled: true,
                        hintText: 'CSS color',
                        contentPadding: EdgeInsets.all(15),
                        isCollapsed: true,
                      ),
                      keyboardType: TextInputType.number,
                      controller: _fontSizeController,
                      style: const TextStyle(fontSize: 18),
                      onChanged: (value) {
                        _updateDecoration();
                      },
                    ),
                  ),
                ],
              ),
              Container(height: 14),
              const Text(
                'Filters: ',
                style: TextStyle(fontSize: 24),
              ),
              Container(height: 2),
              Row(
                children: [
                  GestureDetector(
                    key: filterKey,
                    onTap: () {
                      _showFilters();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: backgroundGrey,
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _selectedFilter.emptyIfNull()
                              .isEmpty == true ? 
                              _selectedFilter.emptyIfNull() :
                              "Error",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Container(width: 10),
                          const Icon(
                            FontAwesomeIcons.chevronDown,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 14),
              const Text(
                'Size: ',
                style: TextStyle(fontSize: 24),
              ),
              Container(height: 2),
              Row(
                children: [
                  Container(
                    width: 85,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fillColor: backgroundGrey,
                        filled: true,
                        hintText: '-',
                        contentPadding: EdgeInsets.all(15),
                        isCollapsed: true,
                      ),
                      keyboardType: TextInputType.number,
                      controller: _widthController,
                      style: const TextStyle(fontSize: 18),
                      onChanged: (value) {
                        _updateDecoration();
                      },
                    ),
                  ),
                  Container(width: 10),
                  const Text('x'),
                  Container(width: 10),
                  Container(
                    width: 85,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fillColor: backgroundGrey,
                        filled: true,
                        hintText: '-',
                        contentPadding: EdgeInsets.all(15),
                        isCollapsed: true,
                      ),
                      keyboardType: TextInputType.number,
                      controller: _heightController,
                      style: const TextStyle(fontSize: 18),
                      onChanged: (value) {
                        _updateDecoration();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}