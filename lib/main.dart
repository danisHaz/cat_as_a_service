import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basics_2/pages/add_cat_page/cat_search_bloc.dart';
import 'package:flutter_basics_2/pages/album_page/albums_bloc.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_bloc.dart';
import 'package:flutter_basics_2/pages/main_page/main_page.dart';
import 'package:flutter_basics_2/repositories/cat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CatRepository().initialize();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white.withOpacity(0.75),
      systemNavigationBarIconBrightness: Brightness.dark));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US')],
      path: 'assets/locales',
      fallbackLocale: const Locale('en', 'US'),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AlbumsCubit(), lazy: false),
        BlocProvider(create: (context) => FeedCubit()),
        BlocProvider(create: (context) => CatSearchBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MainPage(),
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
      ),
    );
  }
}
