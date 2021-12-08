import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/main_app.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await EasyLocalization.ensureInitialized();
	
	runApp(
		EasyLocalization(
			supportedLocales: [Locale('en', 'US')],
			path: 'assets/locales',
			fallbackLocale: Locale('en', 'US'),
			child: const MainApp(),
		)
	);
}
