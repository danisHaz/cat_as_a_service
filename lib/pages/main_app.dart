import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_basics_2/blocs/albums_bloc.dart';
import 'package:flutter_basics_2/blocs/feed_bloc.dart';
import 'package:flutter_basics_2/blocs/main_bloc.dart';
import 'package:flutter_basics_2/pages/albums.dart';
import 'package:flutter_basics_2/shared/models/bottom_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_basics_2/pages/main_page/bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';

import 'feed_page/feed_screen.dart';

class MainApp extends StatelessWidget {

	const MainApp({Key? key}): super(key: key);

	@override
	Widget build(BuildContext context) {
		return MultiBlocProvider(
			providers: [
				BlocProvider(create: (context) => AlbumsCubit()),
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => FeedCubit())
			],
		  child: MaterialApp(
				home: Scaffold(
					appBar: AppBar(title: Text("main_app_bar_title".tr())),
					bottomNavigationBar: BottomBar(key: key),
          body: BlocBuilder<MainCubit, BottomBarState>(
            builder: (context, state) {
              if (state is BottomBarAddCatState) {
                // todo: not implemented
              } else if (state is BottomBarAlbumsState) {
                return AlbumsPage(key: key);
              } else if (state is BottomBarFeedState) {
                return const FeedPage();
              } else if (state is BottomBarErrorState) {
                state.printError();
                throw state.err;
              } else {
                // unidentified state
              }

              return const Text("Not yet implemented");
            },
          ),
				),
				localizationsDelegates: context.localizationDelegates,
				locale: context.locale,
				supportedLocales: context.supportedLocales,
			)
		);
	}
}