import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/settings/settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
      return Container(
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SettingsRow(
              title: Text('settings.theme'.tr()),
              control: Row(
                children: [
                  Icon(Icons.wb_sunny_outlined),
                  Switch(
                    value: state.theme == ThemeMode.dark,
                    // activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (value) {
                      context
                          .read<SettingsCubit>()
                          .setTheme(!value ? ThemeMode.light : ThemeMode.dark);
                    },
                  ),
                  Icon(Icons.nightlight_round),
                ],
              ),
            ),
            SettingsRow(
              title: Text('settings.language'.tr()),
              control: DropdownButton<Locale>(
                value: EasyLocalization.of(context)!.currentLocale,
                onChanged: (value){
                  if(value != null){
                    EasyLocalization.of(context)?.setLocale(Locale(value.languageCode));
                  }
                },
                items: EasyLocalization.of(context)!.supportedLocales.map((e){
                  return DropdownMenuItem(
                    child: Text(e.languageCode),
                    value: e,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class SettingsRow extends StatelessWidget {
  final Widget title;
  final Widget control;

  const SettingsRow({Key? key, required this.title, required this.control})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [title, control],
    );
  }
}
