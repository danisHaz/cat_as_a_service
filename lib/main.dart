import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/main_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_basics_2/repositories/cat_repository.dart';

import 'firebase_options.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await EasyLocalization.ensureInitialized();

	await Firebase.initializeApp(
		options: DefaultFirebaseOptions.currentPlatform,
	);

	CatRepository().initialize();

	runApp(
		EasyLocalization(
			supportedLocales: const [Locale('en', 'US')],
			path: 'assets/locales',
			fallbackLocale: const Locale('en', 'US'),
      child: const MainApp(),
		)
	);
}
