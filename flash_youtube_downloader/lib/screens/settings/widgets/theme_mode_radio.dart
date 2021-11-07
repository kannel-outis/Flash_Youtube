import 'package:flash_youtube_downloader/screens/settings/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeModeRadio extends ConsumerWidget {
  final ThemeMode mode;
  const ThemeModeRadio({Key? key, required this.mode}) : super(key: key);

  String get label {
    final splitMode = mode.toString().split(".")[1].split("");
    final capFirstLetter = splitMode.first.toUpperCase();
    splitMode.replaceRange(0, 1, [capFirstLetter]);
    return splitMode.join();
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final themeMode = watch(SettingsProvider.themeSettings);
    final themeModeNotifier = watch(SettingsProvider.themeSettings.notifier);
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        themeModeNotifier.setAppTheme(mode);
      },
      child: Row(
        children: [
          Radio<ThemeMode>(
            value: mode,
            groupValue: themeMode,
            onChanged: (value) {
              themeModeNotifier.setAppTheme(value!);
            },
          ),
          Text(
            "$label Theme Mode",
            style: theme.textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
