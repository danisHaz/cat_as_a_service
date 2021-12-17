import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/pages/albums_page/albums.dart';
import 'package:flutter_basics_2/pages/search_cat/cat_search.dart';
import 'package:flutter_basics_2/pages/settings/settings.dart';
import 'package:flutter_basics_2/shared/widgets/top_offset_provider.dart';
import 'package:flutter_basics_2/utils/system_chrome.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../feed_page/feed_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  MainPageState() : super();

  MainScreenPageType currentPage = MainScreenPageType.feedScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: TopOffsetProvider(
          child: SafeArea(child: _buildCurrentScreen()),
          context: context,
        ),
        bottomNavigationBar: _buildNavbar(context),
      extendBody: false,
    );
  }

  Widget _buildNavbar(BuildContext context) {
    var activeColor = Theme.of(context).colorScheme.primary;
    return Material(
      elevation: 6,
      color: Theme.of(context).bottomAppBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            alignment: Alignment.topCenter,
            iconSize: 25,
            icon: Icon(
              FontAwesomeIcons.dice,
              color: currentPage == MainScreenPageType.feedScreen
                  ? activeColor
                  : null,
            ),
            onPressed: () {
              setState(() {
                currentPage = MainScreenPageType.feedScreen;
              });
            },
          ),
          IconButton(
            iconSize: 30,
            icon: Icon(
              Icons.add,
              color: currentPage == MainScreenPageType.addCatScreen
                  ? activeColor
                  : null,
            ),
            onPressed: () {
              setState(() {
                currentPage = MainScreenPageType.addCatScreen;
              });
            },
          ),
          IconButton(
            iconSize: 25,
            icon: Icon(
              Icons.collections,
              color: currentPage == MainScreenPageType.albumsScreen
                  ? activeColor
                  : null,
            ),
            onPressed: () {
              setState(() {
                currentPage = MainScreenPageType.albumsScreen;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: null,
            ),
            onPressed: () async {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10))),
                // expand: false,
                context: context,
                builder: (context) {
                  return SettingsPage();
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildCurrentScreen() {
    if (currentPage == MainScreenPageType.addCatScreen) {
      return const CatSearchPage();
    }
    if (currentPage == MainScreenPageType.albumsScreen) {
      return const AlbumsPage(key: Key('2'));
    }
    if (currentPage == MainScreenPageType.feedScreen) {
      return const FeedPage(key: Key('0'));
    }

    return const Text(
      "Not yet implemented",
      key: Key('1'),
    );
  }
}

enum MainScreenPageType {
  feedScreen,
  addCatScreen,
  albumsScreen,
}
