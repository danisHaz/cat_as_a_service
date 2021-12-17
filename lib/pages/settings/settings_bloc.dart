import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState {
  final ThemeMode theme;

  const SettingsState({
    required this.theme,
  });

  SettingsState copyWith({
    ThemeMode? theme,
  }) {
    return SettingsState(
      theme: theme ?? this.theme,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(theme: ThemeMode.light)) {
    _setup();
  }

  Future<void> _setup() async {
    final prefs = await SharedPreferences.getInstance();
    emit(SettingsState(
      theme: !(prefs.getBool('is_dark') ?? false) ? ThemeMode.light : ThemeMode.dark,
    ));
  }

  Future<void> setTheme(ThemeMode mode) async{
    emit(state.copyWith(theme: mode));
    (await SharedPreferences.getInstance()).setBool('is_dark', mode == ThemeMode.dark);
  }

}
