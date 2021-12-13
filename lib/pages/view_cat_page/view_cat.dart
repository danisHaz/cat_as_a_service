import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basics_2/pages/view_cat_page/view_cat_state.dart';
import 'package:flutter_basics_2/shared/album.dart';
import 'package:flutter_basics_2/shared/widgets/custom_appbar.dart';
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
  }) : super(key: key);

  @override
  _CatViewPageState createState() => _CatViewPageState();
}

class _CatViewPageState extends State<CatViewPage>
    with SingleTickerProviderStateMixin {
  bool _showAppBar = true;

  _flipAppbar() {
    setState(() {
      _showAppBar = !_showAppBar;
    });

    if (_showAppBar) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.white.withOpacity(0.75),
          systemNavigationBarIconBrightness: Brightness.dark));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.black,
          systemNavigationBarColor: Colors.black.withOpacity(0.75),
          systemNavigationBarIconBrightness: Brightness.light));
    }
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white.withOpacity(0.75),
        systemNavigationBarIconBrightness: Brightness.dark));
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _showAppBar
          ? const CustomAppbar(
              name: "",
              actions: [],
            )
          : null,
      body: GestureDetector(
        child: CatPageBuilder(data: widget.data).build(),
        onTap: () {
          _flipAppbar();
        },
      ),
    );
  }
}
