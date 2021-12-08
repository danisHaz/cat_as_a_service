import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/pages/main_page/bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class MainApp extends StatelessWidget {

	const MainApp({Key? key}): super(key: key);

	@override
	Widget build(BuildContext context) {
		return MediaQuery(
			data: const MediaQueryData(),
			child: MaterialApp(
				home: Scaffold(
					appBar: AppBar(
						title: Text("main_app_bar_title".tr()),
					),
					bottomNavigationBar: BottomBar(key: key)
				),
				localizationsDelegates: context.localizationDelegates,
				locale: context.locale,
				supportedLocales: context.supportedLocales,
			)
		);
	}
}