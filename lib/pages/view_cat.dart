import 'package:flutter/material.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_basics_2/widgets/sliding_appbar.dart';
import 'package:photo_view/photo_view.dart';

class CatViewPage extends StatefulWidget {
  final Cat cat;
  final Object heroTag;

  const CatViewPage({Key? key, required this.cat, required this.heroTag})
      : super(key: key);

  @override
  _CatViewPageState createState() => _CatViewPageState();
}

class _CatViewPageState extends State<CatViewPage>
    with SingleTickerProviderStateMixin {
  var _showAppBar = false;
  late final AnimationController _appBarSlideController;

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
        child: Hero(
          tag: widget.heroTag,
          child: PhotoView(
            imageProvider: NetworkImage('$BASE_URL${widget.cat.url}'),
            minScale: PhotoViewComputedScale.contained,
          ),
        ),
        onTap: () {
          setState(() {
            _showAppBar = !_showAppBar;
          });
        },
      ),
    );
  }
}
