import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basics_2/pages/albums_page/albums_bloc.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_bloc.dart';
import 'package:flutter_basics_2/pages/main_page/main_page.dart';
import 'package:flutter_basics_2/pages/search_cat/cat_search_bloc.dart';
import 'package:flutter_basics_2/pages/settings/settings_bloc.dart';
import 'package:flutter_basics_2/repositories/cat_repository.dart';
import 'package:flutter_basics_2/shared/transitions_builder.dart';
import 'package:flutter_basics_2/shared/widgets/offset_provider.dart';
import 'package:flutter_basics_2/utils/system_chrome.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetIt.I.registerSingleton<CatRepository>(await CatRepository()
    ..initialize());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru')],
      path: 'assets/locales',
      fallbackLocale: Locale('en'),
      useOnlyLangCode: true,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageTransitionTheme = PageTransitionsTheme(builders: {
      for (var entry in TargetPlatform.values)
        entry: CatPageTransitionsBuilder(),
    });
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AlbumsCubit(), lazy: false),
        BlocProvider(create: (context) => FeedCubit()),
        BlocProvider(create: (context) => CatSearchBloc()),
        BlocProvider(create: (context) => SettingsCubit()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return OffsetProvider(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const MainPage(),
              builder: (context, child) {
                return AnnotatedRegion<SystemUiOverlayStyle>(
                  child: child ?? Text('Something went wrong'),
                  value: getUiStyle(
                    Theme.of(context),
                  ),
                );
              },
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              theme: ThemeData.light().copyWith(
                pageTransitionsTheme: pageTransitionTheme,
                colorScheme: const ColorScheme.light(
                    primary: Colors.lightBlue, primaryVariant: Colors.blue),
                scaffoldBackgroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(230, 230, 230, 1),
              ),
              darkTheme: ThemeData.dark().copyWith(
                pageTransitionsTheme: pageTransitionTheme,
                toggleableActiveColor: Colors.lightBlue,
                backgroundColor:
                    const Color(0x1AFFFFFF), // colorScheme: ColorScheme.dark(
                //     primary: Colors.lightBlue, primaryVariant: Colors.blue),
              ),
              themeMode: state.theme,
            ),
          );
        },
      ),
    );
  }
}
