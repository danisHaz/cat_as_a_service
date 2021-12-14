import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          ?  widget.appBar
          : null,
      body: GestureDetector(
        child: widget.body,
        onTap: () {
          _flipAppbar();
        },
      ),
    );
  }
}
