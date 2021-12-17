import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/settings/settings_bloc.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_item.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_popup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final GlobalKey languageWidgetkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
      return Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SettingsRow(
              title: Text('settings.theme'.tr()),
              control: Row(
                children: [
                  const Icon(Icons.wb_sunny_outlined),
                  Switch(
                    inactiveTrackColor: Theme.of(context).backgroundColor,
                    value: state.theme == ThemeMode.dark,
                    onChanged: (value) {
                      context
                          .read<SettingsCubit>()
                          .setTheme(!value ? ThemeMode.light : ThemeMode.dark);
                    },
                  ),
                  const Icon(Icons.nightlight_round),
                ],
              ),
            ),
            SettingsRow(
                title: Text('settings.language'.tr()),
                control: GestureDetector(
                  onTap: () {
                    _showLanguages(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    key: languageWidgetkey,
                    child: Row(
                      children: [
                        Text(
                          EasyLocalization.of(context)!
                              .currentLocale!
                              .languageCode,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Icon(
                          FontAwesomeIcons.chevronDown,
                          size: 10,
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      );
    });
  }

  _showLanguages(BuildContext context) async {
    final filters = EasyLocalization.of(context)!.supportedLocales.map((e) {
          return DropdownItem(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Text(
                e.languageCode,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            value: e,
          );
        }).toList(),
        rez = await openDropdown(context, languageWidgetkey, filters);
    if (rez != null) {
      EasyLocalization.of(context)?.setLocale(Locale(rez.languageCode));
    }
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
