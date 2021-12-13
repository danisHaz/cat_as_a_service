import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_basics_2/pages/album_page/albums_bloc.dart';
import 'package:flutter_basics_2/pages/add_cat_page/cat_search_bloc.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_bloc.dart';
import 'package:flutter_basics_2/pages/main_bloc.dart';
import 'package:flutter_basics_2/pages/album_page/albums.dart';
import 'package:flutter_basics_2/pages/add_cat_page/cat_search.dart';
import 'package:flutter_basics_2/shared/bottom_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_basics_2/pages/main_page/bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';

import 'feed_page/feed_screen.dart';

class MainApp extends StatefulWidget {

	const MainApp({Key? key}): super(key: key);

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  MainAppState(): super();

  SlideTransition? transition = null;
  final tweens = [
    Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ),
    Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ),
  ];

  int tweensIndex = 0;
  int currentPageNumber = 0;
  

	@override
	Widget build(BuildContext context) {
    const txt = "Cat as a service";
		return MultiBlocProvider(
			providers: [
				BlocProvider(create: (context) => AlbumsCubit()),
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => FeedCubit()),
        BlocProvider(create: (context) => CatSearchBloc()),
			],
		  child: MaterialApp(
				home: Scaffold(
					appBar: AppBar(title: Text(txt)),
					bottomNavigationBar: BottomBar(key: widget.key),
          body: BlocBuilder<MainCubit, BottomBarState>(
            builder: (context, state) =>_bottomBarWidget(state),
          ),
				),
				localizationsDelegates: context.localizationDelegates,
				locale: context.locale,
				supportedLocales: context.supportedLocales,
			)
		);
	}

  Widget _bottomBarWidget(BottomBarState state) {
    if (state is BottomBarAddCatState) {
      // todo: not implemented
      if (currentPageNumber == 0) {
        tweensIndex = 0;
      } else if (currentPageNumber == 2) {
        tweensIndex = 1;
      }
      currentPageNumber = 1;
      return const CatSearchPage();
    } else if (state is BottomBarAlbumsState) {
      currentPageNumber = 2;
      tweensIndex = 0;
      return const AlbumsPage(key: Key('2'));
    } else if (state is BottomBarFeedState) {
      currentPageNumber = 0;
      tweensIndex = 1;
      return const FeedPage(key: Key('0'));
    } else if (state is BottomBarErrorState) {
      state.printError();
      throw state.err;
    }
    // unidentified state

    return const Text("Not yet implemented", key: Key('1'),);
  }
}