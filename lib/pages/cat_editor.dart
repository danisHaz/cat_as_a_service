import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/shared/widgets/action_buttons.dart';
import 'package:flutter_basics_2/shared/widgets/custom_appbar.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_basics_2/widgets/progress_bar.dart';

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
  var _selectedFilter = CatDecorationFilter.none;

  @override
  void initState() {
    super.initState();
    cat = widget.cat;
    _selectedFilter = cat.filter ?? CatDecorationFilter.none;
    _textController = TextEditingController(text: cat.text);
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

  String _generateUrl() {
    String finalUrl
      = "$BASE_URL${cat.url}" +
        (cat.text?.emptyIfNull().isEmpty == true ? "" : "/says/${cat.text}")
        + "?filter=${cat.filter.emptyIfNull()}"
        + "&color=${cat.textColor.emptyIfNull()}&type=${cat.type.emptyIfNull()}"
        + "&size=${cat.fontSize ?? ""}&height=${cat.height ?? ""}&width=${cat.width ?? ""}";
    return finalUrl;
  }
  
  Widget _buildPicture() => Center(
        child: Container(
          clipBehavior: Clip.antiAlias,
          constraints: const BoxConstraints(maxHeight: 300),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Hero(
            tag: widget.heroTag,
            child: CachedNetworkImage(
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
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        name: 'Cat editor',
        actions: [
          SaveCatButton(cat: cat),
          ShareCatButton(cat: cat),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPicture(),
          const Text('Text'),
          TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(
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
          const Text('Filters'),
          Wrap(
            children: _selectedFilter.customMap((e) {
              if (_selectedFilter.equals(e)) {
                return ElevatedButton(
                  onPressed: () => {
                    
                  },
                  child: Text(e.emptyIfNull())
                );
              } else {
                return OutlinedButton(
                  onPressed: () {
                    _selectedFilter = e;
                    _updateDecoration();
                  },
                  child: Text(e.emptyIfNull())
                );
              }
            }).toList(),
          ),
        ],
      ),
    );
  }
}
