import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/pages/main_page/bottom_bar.dart';

class MainApp extends StatelessWidget {

	const MainApp({Key? key}): super(key: key);

	@override
	Widget build(BuildContext context) {
		return MediaQuery(
			data: const MediaQueryData(),
			child: MaterialApp(
				home: Scaffold(
					appBar: AppBar(),
					body: Column(
						children: [BottomBar(key: key)],
					),
				)
			)
		);
	}
}