import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_basics_2/pages/album_page/albums_bloc.dart';
import 'package:flutter_basics_2/pages/add_cat_page/cat_search_bloc.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_bloc.dart';
import 'package:flutter_basics_2/pages/album_page/albums.dart';
import 'package:flutter_basics_2/pages/add_cat_page/cat_search.dart';
import 'package:flutter_basics_2/shared/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AlbumsCubit()),
        BlocProvider(create: (context) => FeedCubit()),
        BlocProvider(create: (context) => CatSearchBloc()),
      ],
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(child: _buildCurrentScreen()),
          bottomNavigationBar: _buildNavbar()),
    );
  }

  Widget _buildNavbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          padding: const EdgeInsets.all(6),
          alignment: Alignment.topCenter,
          iconSize: 30,
          icon: Icon(
            FontAwesomeIcons.dice,
            color: currentPage == MainScreenPageType.feedScreen
                ? mainBlue
                : Colors.black,
          ),
          onPressed: () {
            setState(() {
              currentPage = MainScreenPageType.feedScreen;
            });
          },
        ),
        IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.add,
            color: currentPage == MainScreenPageType.addCatScreen
                ? mainBlue
                : Colors.black,
          ),
          onPressed: () {
            setState(() {
              currentPage = MainScreenPageType.addCatScreen;
            });
          },
        ),
        IconButton(
          iconSize: 30,
          icon: Icon(
            Icons.collections,
            color: currentPage == MainScreenPageType.albumsScreen
                ? mainBlue
                : Colors.black,
          ),
          onPressed: () {
            setState(() {
              currentPage = MainScreenPageType.albumsScreen;
            });
          },
        ),
      ],
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
