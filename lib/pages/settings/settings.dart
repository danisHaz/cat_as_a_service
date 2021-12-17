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
              title: Text('Theme'),
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
