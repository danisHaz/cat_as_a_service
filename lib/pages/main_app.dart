import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/pages/albums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {

	const MainApp({Key? key}): super(key: key);

	@override
	Widget build(BuildContext context) {

		return MultiBlocProvider(
			providers: [
				BlocProvider(create: (context) => AlbumsCubit())
			],
		  child: MaterialApp(
		  	home: AlbumsPage(),
		  ),
		);
	}
}