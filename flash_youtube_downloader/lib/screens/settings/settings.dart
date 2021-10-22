import 'package:flash_youtube_downloader/components/custom_will_scope.dart';
import 'package:flash_youtube_downloader/models/content_country.dart';
import 'package:flash_youtube_downloader/screens/settings/providers/settings_provider.dart';
import 'package:flash_youtube_downloader/utils/countries.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player/youtube_player.dart';

import 'widgets/country_drop_down.dart';

// ignore: must_be_immutable
class SettingsPage extends ConsumerWidget {
  SettingsPage({Key? key}) : super(key: key);

  bool switcherValue = false;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final settingsProvider =
        watch(SettingsProvider.settingsChangeNotifierProvider);
    return CustomWillScope(
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: const Text("Settings"),
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
                  height: 70,
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
            ],
          ),
        ),
      ),
    );
  }
}
