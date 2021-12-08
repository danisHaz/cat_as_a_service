import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/main_app.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await EasyLocalization.ensureInitialized();
	
	runApp(
		EasyLocalization(
			supportedLocales: const [Locale('en', 'US')],
			path: 'assets/locales',
			fallbackLocale: const Locale('en', 'US'),
			child: const MainApp(),
		)
	);
}
