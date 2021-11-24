import 'package:flash_youtube_downloader/components/custom_will_scope.dart';
import 'package:flash_youtube_downloader/models/content_country.dart';
import 'package:flash_youtube_downloader/screens/settings/providers/settings_provider.dart';
import 'package:flash_youtube_downloader/utils/countries.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player/youtube_player.dart';

import 'widgets/country_drop_down.dart';
import 'widgets/theme_mode_radio.dart';

// ignore: must_be_immutable
class SettingsPage extends ConsumerWidget {
  SettingsPage({Key? key}) : super(key: key);

  bool switcherValue = false;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final settingsProvider =
        watch(SettingsProvider.settingsChangeNotifierProvider);
    return CustomWillScope(
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: theme.scaffoldBackgroundColor,
          iconTheme: IconThemeData(
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
          title: Text(
            "Settings",
            style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Country Content",
                          style: theme.textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "The changes will reflect once you restart the app.",
                          style: theme.textTheme.caption,
                        ),
                      ],
                    ),
                    SizedBox(
                      child: FutureBuilder<List<ContentCountry>>(
                        future: Future.delayed(
                            const Duration(milliseconds: 300), () {
                          return Country.countries
                              .map((e) => ContentCountry.fromJson(e))
                              .toList();
                        }),
                        initialData: const [],
                        builder: (context, snapshot) {
                          return CountryDropDown(
                            value: settingsProvider.contentCountry,
                            listOfCodes: snapshot.data,
                            onChanged: (value) {
                              settingsProvider.setCountentCountry(value!);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: SizedBox(
                  // height: 70,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Show Comments",
                      style: theme.textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                value: settingsProvider.showComments,
                onChanged: (value) {
                  settingsProvider.setShowComment(value);
                },
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  settingsProvider.setAllowPIP(!settingsProvider.allowPIP);
                },
                child: SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Allow PIP ( Picture-In-Picture )",
                            style: theme.textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "Allow to play video through a small window when homescreen is pressed.",
                            style: theme.textTheme.caption,
                          ),
                        ],
                      ),
                      Switch(
                        value: settingsProvider.allowPIP,
                        onChanged: (allowPIP) {},
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  settingsProvider.setAllowSetPlayerQualityOnQualityChange(
                    !settingsProvider.allowSetPlayerQualityOnQualityChange,
                  );
                },
                child: SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Allow Set player quality from miniplayer",
                            style: theme.textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "Allow to set player quality when user changes the quality from mini player.",
                            style: theme.textTheme.caption,
                          ),
                        ],
                      ),
                      Switch(
                        value: settingsProvider
                            .allowSetPlayerQualityOnQualityChange,
                        onChanged: (allowSetPlayerQualityOnQualityChange) {},
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  settingsProvider.setAutoPlay(
                    !settingsProvider.autoAutoPlay,
                  );
                },
                child: SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AutoPlay",
                            style: theme.textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "Allow Player to Automatically play the next video.",
                            style: theme.textTheme.caption,
                          ),
                        ],
                      ),
                      Switch(
                        value: settingsProvider.autoAutoPlay,
                        onChanged: (autoPlay) {},
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Defualt Player Quality",
                          style: theme.textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    DropdownButton<String>(
                      onChanged: (playerQuality) {
                        settingsProvider.setPlayerQuality(playerQuality!);
                      },
                      underline: const SizedBox(),
                      dropdownColor: theme.scaffoldBackgroundColor,
                      value: settingsProvider.playerQuality.qualityToString,
                      items: YoutubePlayerVideoQuality.values
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e.qualityToString,
                              child: SizedBox(
                                width: 100,
                                child: Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 18,
                                      child: Text(
                                        e.qualityToString,
                                        style: theme.textTheme.bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  settingsProvider.setDeafultDownloadPath();
                },
                child: SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Download Path",
                            style: theme.textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            settingsProvider.filePath.path,
                            style: theme.textTheme.caption,
                          ),
                        ],
                      ),
                      const Icon(Icons.folder_sharp, size: 30),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "App Theme",
                      style: theme.textTheme.bodyText1,
                    ),
                    const SizedBox(height: 20),
                    const ThemeModeRadio(
                      mode: ThemeMode.dark,
                    ),
                    const ThemeModeRadio(
                      mode: ThemeMode.light,
                    ),
                    const ThemeModeRadio(
                      mode: ThemeMode.system,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
