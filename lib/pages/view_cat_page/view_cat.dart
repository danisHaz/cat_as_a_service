import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/view_cat_page/view_cat_state.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_basics_2/widgets/sliding_appbar.dart';
import 'package:logger/logger.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CatViewPage extends StatefulWidget {
  String get _name => runtimeType.toString();
  final CatPageData data;

  const CatViewPage({
    Key? key,
    required this.data,
  }): super(key: key);

  @override
  _CatViewPageState createState() => _CatViewPageState();
}

class _CatViewPageState extends State<CatViewPage>
    with SingleTickerProviderStateMixin {
  bool _showAppBar = false;
  late final AnimationController _appBarSlideController;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _appBarSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SlidingAppBar(
        child: AppBar(
          title: const Text('Look at this cat!'),
        ),
        visible: _showAppBar,
        controller: _appBarSlideController,
      ),
      body: GestureDetector(
        child: CatPageBuilder(data: widget.data).build(),
        onTap: () {
          setState(() {
            _showAppBar = !_showAppBar;
          });
        },
      ),
    );
  }
}
