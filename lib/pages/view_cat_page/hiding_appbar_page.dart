import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basics_2/widgets/sliding_appbar.dart';

class HidingAppBarPage extends StatefulWidget {
  final PreferredSizeWidget appBar;
  final Widget body;

  const HidingAppBarPage({
    Key? key, required this.appBar, required this.body,
  }) : super(key: key);

  @override
  _HidingAppBarPageState createState() => _HidingAppBarPageState();
}

class _HidingAppBarPageState extends State<HidingAppBarPage>
    with SingleTickerProviderStateMixin {
  bool _showAppBar = false;
  late final AnimationController _appBarSlideController;

  @override
  void initState(){
    super.initState();
    _appBarSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      value: 1,
    );
    _updateSystemUI();
  }

  _flipAppbar() {
    setState(() {
      _showAppBar = !_showAppBar;
    });

    _updateSystemUI();
  }

  void _updateSystemUI(){
    if (_showAppBar) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.white.withOpacity(0.75),
          systemNavigationBarIconBrightness: Brightness.dark));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
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
      appBar: SlidingAppBar(
        child: widget.appBar,
        controller: _appBarSlideController,
        visible: _showAppBar,
      ),
      body: GestureDetector(
        child: widget.body,
        onTap: () {
          _flipAppbar();
        },
      ),
    );
  }
}
